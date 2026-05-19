const request = require('supertest');
const { app, server } = require('../index');

afterAll(() => {
  server.close();
});

describe('API Endpoints', () => {

  test('GET / should return 200', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
  });

  test('GET /api/hello should return JSON with message', async () => {
    const res = await request(app).get('/api/hello');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('message');
    expect(res.body.message).toBe('Hello from CSE CI/CD Project!');
    expect(res.body).toHaveProperty('version');
  });

  test('GET /api/health should return status OK', async () => {
    const res = await request(app).get('/api/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('OK');
  });

});
