<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<div class="space m-3 p-5">
  <div class="row">
    <div class="col-md-6 mb-3">
      <div class="h-100">
          <h5 class="card-title">Default state</h5>

          <!-- Static Input -->
          <div class="row mb-3">
            <label for="_dm-staticInput" class="col-sm-3 col-form-label">Static</label>
            <div class="col-sm-9">
              <input
                id="_dm-staticInput"
                type="email"
                class="form-control-plaintext"
                value="username"
              />
            </div>
          </div>
          <!-- END : Static Input -->

          <!-- Text input -->
          <div class="row mb-3">
            <label for="_dm-textInput" class="col-sm-3 col-form-label"
              >Text Input</label
            >
            <div class="col-sm-9">
              <input
                id="_dm-textInput"
                type="text"
                class="form-control"
                placeholder="Default Input"
              />
            </div>
          </div>
          <!-- END : Text input -->

          <!-- Text input with help -->
          <div class="row mb-3">
            <label for="_dm-textInputWitHelp" class="col-sm-3 form-label"
              >With Help</label
            >
            <div class="col-sm-9">
              <input
                id="_dm-textInputWitHelp"
                type="text"
                class="form-control"
                placeholder="Input with help"
                aria-describedby="inputHelp"
              />
              <div id="emailHelp" class="form-text">
                We'll never share your email with anyone else.
              </div>
            </div>
          </div>
          <!-- END : Text input with help -->

          <!-- Floating label -->
          <div class="row mb-3">
            <label for="_dm-floatingInput" class="col-sm-3 form-label"
              >Floating label</label
            >
            <div class="col-sm-9">
              <div class="form-floating mb-3">
                <input
                  id="dm_floatingInput"
                  type="text"
                  class="form-control"
                  placeholder="Username"
                />
                <label for="dm_floatingInput">Username</label>
              </div>
            </div>
          </div>
          <!-- END : Floating label -->

          <!-- Readonly -->
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Readonly</label>
            <div class="col-sm-9">
              <input
                class="form-control"
                type="text"
                value="Readonly input here..."
                aria-label="readonly input example"
                readonly
              />
            </div>
          </div>
          <!-- END : Readonly -->

          <!-- Textarea -->
          <div class="row mb-3">
            <label for="_dm-textareaInput" class="col-sm-3 col-form-label"
              >Textarea</label
            >
            <div class="col-sm-9">
              <textarea
                id="_dm-textareaInput"
                class="form-control"
                placeholder="Textarea"
                rows="5"
              ></textarea>
            </div>
          </div>
          <!-- END : Textarea -->

      </div>
    </div>
    <div class="col-md-6 mb-3">
      <div class="h-100">
          <h5 class="card-title"></h5>

          <!-- Checkboxes -->
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Checkboxes</label>
            <div class="col-sm-9 py-2">
              <div class="form-check mb-2">
                <input
                  id="_dm-blockCheckboxes"
                  class="form-check-input"
                  type="checkbox"
                  checked
                />
                <label for="_dm-blockCheckboxes" class="form-check-label">
                  Option 1 (pre-checked)
                </label>
              </div>

              <div class="form-check mb-2">
                <input
                  id="_dm-blockCheckbox2"
                  class="form-check-input"
                  type="checkbox"
                />
                <label for="_dm-blockCheckbox2" class="form-check-label">
                  Option 2
                </label>
              </div>

              <div class="form-check">
                <input
                  id="_dm-blockCheckbox3"
                  class="form-check-input"
                  type="checkbox"
                />
                <label for="_dm-blockCheckbox3" class="form-check-label">
                  Option 3
                </label>
              </div>
            </div>
          </div>
          <!-- END : Checkboxes -->

          <!-- Inline Checkboxes-->
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Inline Checkboxes</label>
            <div class="col-sm-9 pt-3">
              <div class="form-check form-check-inline">
                <input
                  id="_dm-inlineCheckboxes"
                  class="form-check-input"
                  type="checkbox"
                  autocomplete="off"
                  value="option1"
                  checked
                />
                <label for="_dm-inlineCheckboxes" class="form-check-label"
                  >Pre-checked</label
                >
              </div>

              <div class="form-check form-check-inline">
                <input
                  id="_dm-inlineCheckboxes2"
                  class="form-check-input"
                  type="checkbox"
                  autocomplete="off"
                  value="option2"
                />
                <label for="_dm-inlineCheckboxes2" class="form-check-label"
                  >Option 2</label
                >
              </div>

              <div class="form-check form-check-inline">
                <input
                  id="_dm-inlineCheckboxes3"
                  class="form-check-input"
                  type="checkbox"
                  autocomplete="off"
                  value="option3"
                />
                <label for="_dm-inlineCheckboxes3" class="form-check-label"
                  >Option 3</label
                >
              </div>
            </div>
          </div>
          <!-- END : Inline Checkboxes-->

          <!-- Radios -->
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Radios</label>
            <div class="col-sm-9 pt-3">
              <div class="form-check mb-2">
                <input
                  id="_dm-blockRadios"
                  class="form-check-input"
                  type="radio"
                  name="radioBlockDefault"
                  checked
                />
                <label for="_dm-blockRadios" class="form-check-label">
                  Option 1 ( Pre-checked )
                </label>
              </div>

              <div class="form-check mb-2">
                <input
                  id="_dm-blockRadios2"
                  class="form-check-input"
                  type="radio"
                  name="radioBlockDefault"
                />
                <label for="_dm-blockRadios2" class="form-check-label">
                  Option 2
                </label>
              </div>

              <div class="form-check">
                <input
                  id="_dm-blockRadios3"
                  class="form-check-input"
                  type="radio"
                  name="radioBlockDefault"
                />
                <label for="_dm-blockRadios3" class="form-check-label">
                  Option 3
                </label>
              </div>
            </div>
          </div>
          <!-- END : Radios -->

          <!-- Inline Radios -->
          <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Inline radios</label>
            <div class="col-sm-9 pt-3">
              <div class="form-check form-check-inline">
                <input
                  id="_dm-inlineRadio1"
                  class="form-check-input"
                  type="radio"
                  name="inlineRadioOptions"
                  value="option1"
                  checked
                />
                <label for="_dm-inlineRadio1" class="form-check-label"
                  >Pre-checked</label
                >
              </div>

              <div class="form-check form-check-inline">
                <input
                  id="_dm-inlineRadio2"
                  class="form-check-input"
                  type="radio"
                  name="inlineRadioOptions"
                  value="option2"
                />
                <label for="_dm-inlineRadio2" class="form-check-label"
                  >Option 2</label
                >
              </div>

              <div class="form-check form-check-inline">
                <input
                  id="_dm-inlineRadio3"
                  class="form-check-input"
                  type="radio"
                  name="inlineRadioOptions"
                  value="option3"
                />
                <label for="_dm-inlineRadio3" class="form-check-label"
                  >Option 3</label
                >
              </div>
            </div>
          </div>
          <!-- END : Inline Radios -->

          <!-- File Input -->
          <div class="row mb-3">
            <label for="_dm-fileInput" class="col-sm-3 col-form-label"
              >File input</label
            >
            <div class="col-sm-9">
              <input id="_dm-fileInput" class="form-control" type="file" />
            </div>
          </div>
          <!-- END : File Input -->
      </div>
    </div>
  </div>
</div>
