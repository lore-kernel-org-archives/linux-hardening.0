Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE07C433EF
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888D660524
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 15:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhIEPic (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 5 Sep 2021 11:38:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:42999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEPic (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 5 Sep 2021 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630856245;
        bh=fZ7vsKxWCOzaPR3qCbGl0YI0Eraw0GC3m97Ab8Y+kbc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=f+DyRUnTHDHpKG5RFhJKLMBVvRN/r2TG+iDl8Qe9bVqDGDUfN+WM2gY+yiC8f2Wah
         J5pviBih+VPET/A14BBuXECZOUbDvi/W620bGCwD/VnNN+VWnhYcV0OppttOR+WdAP
         pJ6yu7/dUqxoPLBNxhuADMbRL3k7Jlxy6eY3HbIA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MTzb8-1mW9cU2g3G-00R34o; Sun, 05 Sep 2021 17:37:24 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tifm: Prefer struct_size over open coded arithmetic
Date:   Sun,  5 Sep 2021 17:37:07 +0200
Message-Id: <20210905153707.9638-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dlDqGtucZ1i/nNJA95kJ9Wpmz4cTLAkmeCM7YwrN2YeguLJa5D6
 OmTDJWzvg8HTCX5YwIrPhTKohI1EWDfTXJLNu6MLAhRGdTstoZnTRD0FjQEBvCOYhl+ImMI
 iymLvgykWK4diQQ1M+p9B+rOMm7lU7/sTSIYHiDYqdrtLpSjE6hQvBYGPDRH6aSu6c7XQT1
 BuxsI3ZiY2T+9scDq2L7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KVcdvdjBlNo=:DIBN5sY+6LNuXcWpFglesg
 6s3Tdn2toFe6Ne5mF25vlthbn2QfPsS921MCRoGxuEJ6O/TPQbQf9nCavxPb/PrmJ0Id864Xq
 MFk3LKmM9XRD/QzbT00/EffmsFTeG0sTeViaRkpeYgNHEgL6uc6zewwvUwIIn7JIbP8JdixPZ
 YfSnRnD//s36q8Tu24YwWWhryP2K1VF+oMwcPOeDEdpUN87PX7m1elNkX1ibW8NzufXuIrj9f
 HhCHnXBrpLWkWmmwNJNEFJpfbdUSzfpCPtiZamwedwoQiKn3sj9qG4HqdGYR0F0anvZQ9OLj5
 hzvbGOOsHBfClKQmO5wbMYjVDvKrVGQ9sZIWmdC9tm1g2jo0L3LgvcBHYBM5Bi+QmIqGhyZ+j
 ICBNXyQbv4oUdAS+SSv35CddWnBd2WCRtt8Q4sdGTtbHLrOu213AV2EnopSxxqiMyJoS4s8Dz
 dWcNSqncwW4a2Se6T8uuRd4cf2tZjtF/XddwwEMpIs5RKvoK6f5c8cSuUFO4WvtSsNLcU4/9S
 7n9T2RJtu/pYRi/v6/WmPzwAk9EZPXTFibHhYXo1dfLJyTfWeCakY/w3Iddsu3k9JniUQ8Z/Y
 CYi/F5LIgO7wnICa7tZq8BPjFBADOdlLblFdNCkgSuMeuiggw3cTm7hbHJ6TfvTLq3YZP5QQo
 q0U+6zuLzbUcxYfZTNaJ9SPXHDXyG7KIyKIklAgzeMh78JoutHnQBKOQwAY/UUb+mPkofY30P
 vSPUzH4iBzJI31CdNBw9laKFtZ6uHGd2oH03Gs/fTyiN0t/U5qMDNtefaW8Hl9udbpxth3tnf
 nCdvEeR2CTg760yzPM7Oa9Vd6O8v5CQSdPUaKGnD6As363tXK9NeLu/HBHEOuCYjWuAVTR/df
 GtvjcfY0Av07CBB6OpFntNBWKJioa0GOt78K8bM2JsvH6Uy3HONYeCWtmA9DUUADRJfO7R/KA
 5UNbyd2OsQp1fhO653i95QlDXpKTwX3gTTEpOQkk6F6DLFqZ7+Gz6ar993zhsmJziAxfgEe/R
 e7b2lZzCBgAsxHCMyF1h/JMO87eWZTXw+k75tcJ/iqM0L4gJB1Nm/I7WyR/Se6UiHZyvPZQIk
 pIzAwf9wwUP6U0zIoKkzN98NuviF2qoZ/Wl4xirnB9BttGcaKYSMoBFBw==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + size * count" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/misc/tifm_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index 667e574a7df2..9babf171a035 100644
=2D-- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -177,8 +177,7 @@ struct tifm_adapter *tifm_alloc_adapter(unsigned int n=
um_sockets,
 {
 	struct tifm_adapter *fm;

-	fm =3D kzalloc(sizeof(struct tifm_adapter)
-		     + sizeof(struct tifm_dev*) * num_sockets, GFP_KERNEL);
+	fm =3D kzalloc(struct_size(fm, sockets, num_sockets), GFP_KERNEL);
 	if (fm) {
 		fm->dev.class =3D &tifm_adapter_class;
 		fm->dev.parent =3D dev;
=2D-
2.25.1

