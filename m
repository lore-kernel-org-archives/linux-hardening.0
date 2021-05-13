Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E51CC433ED
	for <linux-hardening@archiver.kernel.org>; Thu, 13 May 2021 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1618C613C3
	for <linux-hardening@archiver.kernel.org>; Thu, 13 May 2021 21:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhEMV2D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 May 2021 17:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhEMV2D (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 May 2021 17:28:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18C461177;
        Thu, 13 May 2021 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620941213;
        bh=BC3GkgVf/RX2ir1IeHWRn287RDY2DK6Xt3/vxYPstpk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZR4MpBX/PYZqViQtuZbTac8x2uVk4h4D0Cw9Zik/R2SvGTdVFmYWK8NyvN+ZnwaNr
         rjIBYb60uSBrT22NFrL/j8JCzsdZyKa2jfEhML+G+jiRAEYWFP2/tGwBVN3TFgA9aF
         cW16B16W7Wb+R5R1pwmcZLcx9TOUi6BIo3UlROVhFmaTz45ZU5mwvylamvPg91oRc7
         6tfII7gbsoBkwNWrJdj7yBgnw4fjpbrjHt9SX4pdi9gRZ7acC79PUwSymXIc6xrnXx
         F1sa+1bjIRYFS5NkQ09eswRJlvH9ejbdO/BGizwygDfoTt1lVqexHBT61oDzuFC5SE
         690kDyOHoZWfw==
Date:   Thu, 13 May 2021 16:27:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] kernel/irq: Use struct_size() in kzalloc()
Message-ID: <20210513212729.GA214145@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows
that, in the worst scenario, could lead to heap overflows.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/irq/generic-chip.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f8f23af6ab0d..cc7cdd26e23e 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -240,9 +240,8 @@ irq_alloc_generic_chip(const char *name, int num_ct, unsigned int irq_base,
 		       void __iomem *reg_base, irq_flow_handler_t handler)
 {
 	struct irq_chip_generic *gc;
-	unsigned long sz = sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
 
-	gc = kzalloc(sz, GFP_KERNEL);
+	gc = kzalloc(struct_size(gc, chip_types, num_ct), GFP_KERNEL);
 	if (gc) {
 		irq_init_generic_chip(gc, name, num_ct, irq_base, reg_base,
 				      handler);
@@ -288,8 +287,11 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
-	int numchips, sz, i;
 	unsigned long flags;
+	int numchips, i;
+	size_t dgc_sz;
+	size_t gc_sz;
+	size_t sz;
 	void *tmp;
 
 	if (d->gc)
@@ -300,8 +302,9 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		return -EINVAL;
 
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	sz = sizeof(*dgc) + numchips * sizeof(gc);
-	sz += numchips * (sizeof(*gc) + num_ct * sizeof(struct irq_chip_type));
+	gc_sz = struct_size(gc, chip_types, num_ct);
+	dgc_sz = struct_size(dgc, gc, numchips);
+	sz = dgc_sz + numchips * gc_sz;
 
 	tmp = dgc = kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
@@ -314,7 +317,7 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
-	tmp += sizeof(*dgc) + numchips * sizeof(gc);
+	tmp += dgc_sz;
 	for (i = 0; i < numchips; i++) {
 		/* Store the pointer to the generic chip */
 		dgc->gc[i] = gc = tmp;
@@ -331,7 +334,7 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
 		/* Calc pointer to the next generic chip */
-		tmp += sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
+		tmp += gc_sz;
 	}
 	return 0;
 }
-- 
2.27.0

