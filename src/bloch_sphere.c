#include <GL/glut.h>
#include <stdbool.h>
#include <math.h>
#include <stdio.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>

int windowHeight = 700;
int windowWidth = 900;
int panelWidth = 220;
float angleX = -59, angleY = -46;
int lastX, lastY;
bool isDragging = false;
float sensitivity = 0.3;
float theta_val, phi_val;
float alpha_re, alpha_im, beta_re, beta_im;

void drawText(float x, float y, float z, const char* text) {
    glRasterPos3f(x, y, z);
    while (*text) {
        glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, *text);
        text++;
    }
}

void drawText2D(float x, float y, const char* text, void* font) {
    glRasterPos2f(x, y);
    while (*text) {
        glutBitmapCharacter(font, *text);
        text++;
    }
}

void drawScaledText2D(float x, float y, const char* text, float scale) {
    void* font;
    if (scale >= 1.5) {
        font = GLUT_BITMAP_HELVETICA_18;
    } else if (scale >= 1.2) {
        font = GLUT_BITMAP_HELVETICA_12;
    } else if (scale >= 0.8) {
        font = GLUT_BITMAP_HELVETICA_10;
    } else {
        font = GLUT_BITMAP_8_BY_13;
    }

    glRasterPos2f(x, y);
    while (*text) {
        glutBitmapCharacter(font, *text);
        text++;
    }
}

void drawArrow(float x, float y, float z, float r, float g, float b) {
    glColor3f(r, g, b);
    glPushMatrix();
    glTranslatef(x * 1.15, y * 1.15, z * 1.15);

    float angle = atan2(sqrt(x*x + y*y), z) * 180.0 / M_PI;
    float axis_x = -y;
    float axis_y = x;
    float axis_magnitude = sqrt(axis_x*axis_x + axis_y*axis_y);

    if (axis_magnitude > 0.001) {
        glRotatef(angle, axis_x, axis_y, 0.0);
    } else if (z < 0) {
        glRotatef(180.0, 1.0, 0.0, 0.0);
    }

    glutSolidCone(0.05, 0.1, 8, 8);
    glPopMatrix();
}

void drawAxes() {
    glLineWidth(2.0);
    glBegin(GL_LINES);
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(1.15, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(-1.15, 0.0, 0.0);
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, 1.15, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, -1.15, 0.0);
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, 0.0, 1.15);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, 0.0, -1.15);
    glEnd();

    drawArrow(1.0, 0.0, 0.0, 1.0, 0.0, 0.0);
    drawArrow(-1.0, 0.0, 0.0, 1.0, 0.0, 0.0);
    drawArrow(0.0, 1.0, 0.0, 0.0, 1.0, 0.0);
    drawArrow(0.0, -1.0, 0.0, 0.0, 1.0, 0.0);
    drawArrow(0.0, 0.0, 1.0, 0.0, 0.0, 1.0);
    drawArrow(0.0, 0.0, -1.0, 0.0, 0.0, 1.0);
}

void drawQubitState(float theta, float phi){
    float x = sin(theta) * cos(phi);
    float y = sin(theta) * sin(phi);
    float z = cos(theta);

    glLineWidth(2.5);
    glBegin(GL_LINES);
    glColor3f(1.0, 0.5, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(x, y, z);
	glEnd();

    glPointSize(20.0);
    glBegin(GL_POINTS);
    glColor3f(1.0, 0.6, 0.0);
    glVertex3f(x, y, z);
    glEnd();
}

void display() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0, (float)windowWidth / windowHeight, 1.0, 100.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0, 0.0, -5.0);
    glRotatef(angleX, 1.0, 0.0, 0.0);
    glRotatef(angleY, 0.0, 1.0, 0.0);

    glEnable(GL_DEPTH_TEST);

    drawAxes();

    glColor3f(0.9, 0.9, 0.9);
    drawText(1.3, 0.0, 0.0, "|+>");
    drawText(-1.4, 0.0, 0.0, "|->");
    drawText(0.0, 1.3, 0.0, "|+i>");
    drawText(0.0, -1.4, 0.0, "|-i>");
    drawText(0.0, 0.0, 1.3, "|0>");
    drawText(0.0, 0.0, -1.4, "|1>");

    glColor3f(0.6, 0.6, 0.6);
    glutWireSphere(1.0, 20, 20);

    drawQubitState(theta_val, phi_val);

    glDisable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0, windowWidth, 0, windowHeight);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    float x = sin(theta_val) * cos(phi_val);
    float y = sin(theta_val) * sin(phi_val);
    float z = cos(theta_val);
    float prob0 = alpha_re * alpha_re + alpha_im * alpha_im;
    float prob1 = beta_re * beta_re + beta_im * beta_im;
    float theta_deg = theta_val * 180.0 / M_PI;
    float phi_deg = phi_val * 180.0 / M_PI;

    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glColor4f(0.1, 0.1, 0.1, 0.85);
    glBegin(GL_QUADS);
    glVertex2f(0, windowHeight);
    glVertex2f(panelWidth, windowHeight);
    glVertex2f(panelWidth, 0);
    glVertex2f(0, 0);
    glEnd();

    char buffer[256];

    float textScale = panelWidth / 220.0;
    float paddingX = panelWidth * 0.05;
    float headerScale = textScale * 1.2;

    int lineSpacing = (int)(22 * textScale);
    int sectionSpacing = (int)(30 * textScale);
    int headerSpacing = (int)(35 * textScale);

    glColor3f(0.3, 0.9, 1.0);
    float yPos = windowHeight - (30 * textScale);

    drawScaledText2D(paddingX, yPos, "QUANTUM STATE", headerScale);
    yPos -= sectionSpacing;

    glColor3f(1.0, 1.0, 1.0);
    snprintf(buffer, sizeof(buffer), "alpha = %.3f%+.3fi", alpha_re, alpha_im);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= lineSpacing;

    snprintf(buffer, sizeof(buffer), "beta  = %.3f%+.3fi", beta_re, beta_im);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= headerSpacing;

    glColor3f(0.3, 0.9, 1.0);
    drawScaledText2D(paddingX, yPos, "PROBABILITIES", headerScale);
    yPos -= sectionSpacing;

    glColor3f(1.0, 1.0, 1.0);
    snprintf(buffer, sizeof(buffer), "P(|0>) = %.4f", prob0);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= lineSpacing;

    snprintf(buffer, sizeof(buffer), "P(|1>) = %.4f", prob1);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= headerSpacing;

    glColor3f(0.3, 0.9, 1.0);
    drawScaledText2D(paddingX, yPos, "BLOCH ANGLES", headerScale);
    yPos -= sectionSpacing;

    glColor3f(1.0, 1.0, 1.0);
    snprintf(buffer, sizeof(buffer), "theta = %.4f rad", theta_val);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= lineSpacing;

    snprintf(buffer, sizeof(buffer), "      = %.2f deg", theta_deg);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= (int)(26 * textScale);

    snprintf(buffer, sizeof(buffer), "phi   = %.4f rad", phi_val);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= lineSpacing;

    snprintf(buffer, sizeof(buffer), "      = %.2f deg", phi_deg);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= headerSpacing;

    glColor3f(0.3, 0.9, 1.0);
    drawScaledText2D(paddingX, yPos, "CARTESIAN", headerScale);
    yPos -= sectionSpacing;

    glColor3f(1.0, 1.0, 1.0);
    snprintf(buffer, sizeof(buffer), "x = %.4f", x);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= lineSpacing;

    snprintf(buffer, sizeof(buffer), "y = %.4f", y);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= lineSpacing;

    snprintf(buffer, sizeof(buffer), "z = %.4f", z);
    drawScaledText2D(paddingX, yPos, buffer, textScale);
    yPos -= (40 * textScale);

    glColor3f(0.3, 0.9, 1.0);
    drawScaledText2D(paddingX, yPos, "VIEW ROTATION", headerScale);
    yPos -= sectionSpacing;

    glColor3f(0.7, 0.7, 0.7);
    snprintf(buffer, sizeof(buffer), "X: %.0f  Y: %.0f", angleX, angleY);
    drawScaledText2D(paddingX, yPos, buffer, textScale);

    // Legend at bottom
    yPos = (60 * textScale);
    glColor3f(0.3, 0.9, 1.0);
    drawScaledText2D(paddingX, yPos, "LEGEND", headerScale);
    yPos -= lineSpacing;
    glColor3f(1.0, 0.0, 0.0);
    drawScaledText2D(paddingX, yPos, "X-axis", textScale);
    yPos -= (18 * textScale);
    glColor3f(0.0, 1.0, 0.0);
    drawScaledText2D(paddingX, yPos, "Y-axis", textScale);
    yPos -= (18 * textScale);
    glColor3f(0.0, 0.0, 1.0);
    drawScaledText2D(paddingX, yPos, "Z-axis", textScale);

    glutSwapBuffers();
}

void reshape(int width, int height) {
    if (height == 0) height = 1;
    windowWidth = width;
    windowHeight = height;

    panelWidth = (int)(width * 0.24);
    
    if (panelWidth < 200) panelWidth = 200;
    if (panelWidth > 320) panelWidth = 320;

    glViewport(0, 0, width, height);
    glutPostRedisplay();
}

void mouse(int button, int state, int x, int y) {
    if (button == GLUT_LEFT_BUTTON) {
        isDragging = (state == GLUT_DOWN);
        lastX = x;
        lastY = y;
    }
}

void motion(int x, int y) {
    if (isDragging) {
        int dx = x - lastX;
        int dy = y - lastY;

        angleY += dx * sensitivity;
        angleX += dy * sensitivity;

        lastX = x;
        lastY = y;
        glutPostRedisplay();
    }
}

void init() {
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_POINT_SMOOTH);
    glEnable(GL_LINE_SMOOTH);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glMatrixMode(GL_PROJECTION);
    gluPerspective(45.0, 1.0, 1.0, 100.0);
    glMatrixMode(GL_MODELVIEW);
}

CAMLprim value bloch_native(value phi, value theta, value a_re, value a_im, value b_re, value b_im) {
    CAMLparam5(phi, theta, a_re, a_im, b_re);
    CAMLxparam1(b_im);

    phi_val = Double_val(phi);
    theta_val = Double_val(theta);
    alpha_re = Double_val(a_re);
    alpha_im = Double_val(a_im);
    beta_re = Double_val(b_re);
    beta_im = Double_val(b_im);

    int argc = 1;
    char *argv[] = {"qcaml", NULL};

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(windowWidth, windowHeight);
    glutCreateWindow("qcaml");

    init();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutMouseFunc(mouse);
    glutMotionFunc(motion);

    glutMainLoop();

    CAMLreturn(Val_unit);
}

CAMLprim value bloch_bytecode(value *argv, int argn) {
    return bloch_native(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}
