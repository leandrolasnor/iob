import React from 'react'
import { useForm } from 'react-hook-form'
import {sign_in, sign_up} from './actions'
import { useDispatch } from 'react-redux'
import { Col, Row, Card, Form, Accordion, Container, FloatingLabel, Button } from 'react-bootstrap'

const Auth = () => {
  const {register, handleSubmit, reset} = useForm()
  const dispatch = useDispatch()

	return (
    <Container lg={12} md={12} sm={12} xs={12}>
      <Row style={{backgroundColor: 'rgba(0, 0, 0, 0.9)'}}>
        <Col className='text-light mt-4 mb-4' lg={{span:6, offset:3}}>
          <Accordion defaultActiveKey="0">
            <Accordion.Item eventKey="0">
              <Accordion.Header>
                <h3 className='text-light font-weight-light'>Sign in</h3>
              </Accordion.Header>
              <Accordion.Body>
                <Card.Text lg={12}>
                  <Form onSubmit={handleSubmit(data => dispatch([sign_in(data), reset()]))}>
                    <Form.Group>
                      <Col lg={12}>
                        <FloatingLabel label="E-mail">
                          <Form.Control placeholder="E-mail" type="email" {...register('email')} />
                        </FloatingLabel>
                      </Col>
                      <Col lg={12}>
                        <FloatingLabel label="Password">
                          <Form.Control placeholder="Password" type='password' {...register('password')} />
                        </FloatingLabel>
                      </Col>
                      <Col lg={6} md={12} sm={12} xs={12}>
                        <Button className='mt-3' variant="success" type="submit">Sign In</Button>
                      </Col>
                    </Form.Group>
                  </Form>
                </Card.Text>
              </Accordion.Body>
            </Accordion.Item>
          </Accordion>
          {/* <Accordion defaultActiveKey='0'>
            <Card className='bg-dark'>
              <Accordion.Toggle as={Card.Header} eventKey='0'>
                <h3 className='text-light font-weight-light'>Sign in</h3>
              </Accordion.Toggle>
              <Accordion.Collapse eventKey='0'>
                <Card.Body>
                  <Card.Text lg={12}>
                    <Form onSubmit={handleSubmit(data => dispatch([sign_in(data), reset()]))}>
                      <Form.Group>
                        <Col lg={12}>
                          <FloatingLabel label="E-mail">
                            <Form.Control placeholder="E-mail" type="email" {...register('email')} />
                          </FloatingLabel>
                        </Col>
                        <Col lg={12}>
                          <FloatingLabel label="Password">
                            <Form.Control placeholder="Password" type='password' {...register('password')} />
                          </FloatingLabel>
                        </Col>
                        <Col lg={6} md={12} sm={12} xs={12}>
                          <Button className='mt-3' variant="success" type="submit">Sign In</Button>
                        </Col>
                      </Form.Group>
                    </Form>
                  </Card.Text>
                </Card.Body>
              </Accordion.Collapse>
            </Card>
            <Card className='bg-dark'>
              <Accordion.Toggle as={Card.Header} eventKey='1'>
                <h3 className='text-light font-weight-light'>Sign up</h3>
              </Accordion.Toggle>
              <Accordion.Collapse eventKey='1'>
                <Card.Body>
                  <Card.Text lg={12}>
                    <Form onSubmit={handleSubmit(data => dispatch([sign_up(data), reset()]))}>
                      <Form.Group>
                        <Col>
                          <FloatingLabel label="E-mail">
                            <Form.Control placeholder="E-mail" type="email" {...register('email')} />
                          </FloatingLabel>
                        </Col>
                        <Col>
                          <FloatingLabel label="Password">
                            <Form.Control placeholder="Password" type='password' {...register('password')} />
                          </FloatingLabel>
                        </Col>
                        <Col>
                          <FloatingLabel label="Confirm Password">
                            <Form.Control placeholder="Confirm Password" type='password' {...register('password_confirmation')} />
                          </FloatingLabel>
                        </Col>
                        <Col lg={6} md={12} sm={12} xs={12}>
                          <Button className='mt-2' variant="success" type="submit">Sign Up</Button>
                        </Col>
                      </Form.Group>
                    </Form>
                  </Card.Text>
                </Card.Body>
              </Accordion.Collapse>
            </Card>
          </Accordion> */}
        </Col>
      </Row>
    </Container>
	)
}

export default Auth
