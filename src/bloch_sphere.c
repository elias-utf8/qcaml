#include <GL/glut.h>
#include <stdbool.h>
#include <math.h>
#include <stdio.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>

int windowHeight = 500;
int windowWidth = 500;
float angleX = -59, angleY = -46;
int lastX, lastY;
bool isDragging = false;
float sensitivity = 0.3;

float theta_val, phi_val;



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
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(1.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(-1.0, 0.0, 0.0);
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, -1.0, 0.0);
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(0.0, 0.0, -1.0);
    glEnd();
}

void drawQubitState(float theta, float phi){
    float x = sin(theta) * cos(phi);
    float y = sin(theta) * sin(phi);
    float z = cos(theta);
    glPointSize(15.0);
    glBegin(GL_POINTS);
    glColor3f(1.0, 0.5, 0.0);
    glVertex3f(x, y, z);
    glEnd();
    glBegin(GL_LINES);
    glColor3f(1.0, 0.5, 0.0);
    glVertex3f(0.0, 0.0, 0.0); glVertex3f(x, y, z);
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
    drawText(1.1, 0.0, 0.0, "|+>");
    drawText(-1.1, 0.0, 0.0, "|->");
    drawText(0.0, 1.1, 0.0, "|+i>");
    drawText(0.0, -1.1, 0.0, "|-i>");
    drawText(0.0, 0.0, 1.1, "|0>");
    drawText(0.0, 0.0, -1.1, "|1>");
    
    glColor3f(0.5, 0.5, 0.5);
    glutWireSphere(1, 10, 10);
    
    drawQubitState(theta_val, phi_val);
    
    glMatrixMode(GL_PROJECTION);
    glPushMatrix();
    glLoadIdentity();
    gluOrtho2D(0, windowWidth, 0, windowHeight);
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix();
    glLoadIdentity();
    
    char buffer[50];
    snprintf(buffer, sizeof(buffer), "X:%.0f Y:%.0f", angleX, angleY);
    glColor3f(1.0, 1.0, 1.0);
    glRasterPos2f(windowWidth - 120, 20);
    for(char *c = buffer; *c; c++) {
        glutBitmapCharacter(GLUT_BITMAP_HELVETICA_12, *c);
    }
    
    glPopMatrix();
    glMatrixMode(GL_PROJECTION);
    glPopMatrix();
    glMatrixMode(GL_MODELVIEW);
    
    glutSwapBuffers();
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

CAMLprim value bloch(value phi, value theta) {
    CAMLparam2(phi, theta);
    
    theta_val = Double_val(theta);
    phi_val = Double_val(phi);
    
    int argc = 1;
    char *argv[] = {"qcaml", NULL};
    
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(windowWidth, windowHeight);
    glutCreateWindow("qcaml");
    
    init();
    glutDisplayFunc(display);
    glutMouseFunc(mouse);
    glutMotionFunc(motion);
    
    glutMainLoop();
    
    CAMLreturn(Val_unit);
}
