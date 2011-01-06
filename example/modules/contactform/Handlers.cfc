<cfcomponent
    extends="pistachio.module.Handlers">
    <cfscript>

        public function index(
            formComponent="ContactForm",
            templateName="contactform\index.cfm")
        {
            var contactForm = CreateObject("component", formComponent)
                .setController(getController())
                .init();

            if (getRequest().isPost()) {
                contactForm.setCollection(
                    getRequest().getCollection());

                if (contactForm.isValid()) {
                    contactForm.process();
                }
            }

            return render(templateName, {
                contactForm=contactForm
            });
        }

        public function success(
            templateName="contactform\success.cfm")
        {
            return render(templateName);
        }

    </cfscript>
</cfcomponent>
