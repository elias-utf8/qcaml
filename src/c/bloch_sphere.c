#include <GL/glut.h>
#include <stdbool.h>

float angleX = 0, angleY = 0;
int lastX, lastY;
bool isDragging = false;

void drawText(float x, float y, float z, const char* text) {
    glRasterPos3f(x, y, z);
    while (*text) {
        glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, *text);
        text++;
    }
}

void drawAxes() {
    glLineWidth(3.0);
    glBegin(GL_LINES);
    // Axe X
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(1.0, 0.0, 0.0);

    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(-1.0, 0.0, 0.0);
    // Axe Y
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(0.0, 1.0, 0.0);

    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(0.0, -1.0, 0.0);
    // Axe Z
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 1.0);

    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, -1.0);
    glEnd();
}

void display() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();
    glTranslatef(0.0, 0.0, -5.0);
    glRotatef(angleX, 1.0, 0.0, 0.0);
    glRotatef(angleY, 0.0, 1.0, 0.0);
    drawAxes();

    glColor3f(1.0, 1.0, 1.0);
    drawText(1.1, 0.0, 0.0, "X");

    glColor3f(1.0, 1.0, 1.0);
    drawText(0.0, 1.1, 0.0, "Y");

    glColor3f(1.0, 1.0, 1.0);
    drawText(0.0, 0.0, 1.1, "|0>");
    drawText(0.0, 0.0, -1.1, "|1>⟩");


    glColor3f(0.5, 0.5, 0.5);
    glutWireSphere(1, 10, 10);
    glutSwapBuffers();
}

void mouse(int button, int state, int x, int y) {
    if (button == GLUT_LEFT_BUTTON) {
        if (state == GLUT_DOWN) {
            isDragging = true;
            lastX = x;
            lastY = y;
        } else {
            isDragging = false;
        }
    }
}

void motion(int x, int y) {
    if (isDragging) {
        angleY += (x - lastX) * 0.5;
        angleX += (y - lastY) * 0.5;
        lastX = x;
        lastY = y;
        glutPostRedisplay();
    }
}

void init() {
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glEnable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    gluPerspective(45.0, 1.0, 1.0, 100.0);
    glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(500, 500);
    glutCreateWindow("qcaml");
    init();
    glutDisplayFunc(display);
    glutMouseFunc(mouse);
    glutMotionFunc(motion);
    glutMainLoop();
    return 0;
}
