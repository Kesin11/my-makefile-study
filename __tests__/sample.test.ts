import { Model } from '../src/model'

describe('Model', () => {
  it('new', () => {
    const name = 'bob'
    const model = new Model(name)

    expect(model.name).toBe(name)
  })
})