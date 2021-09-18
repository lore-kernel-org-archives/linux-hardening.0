Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B622C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 18 Sep 2021 15:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096F861100
	for <linux-hardening@archiver.kernel.org>; Sat, 18 Sep 2021 15:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhIRPHC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 18 Sep 2021 11:07:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:54909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236670AbhIRPHC (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 18 Sep 2021 11:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631977519;
        bh=rLUVq/5WjZwOkbgA+dP4sfu+nqx8j/0kB4xgX5lXHN8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ee/5Qs0MJ3qCddW0ywPH8NBrV0b3YY98Me+BsMuLbtomtv8lu3CnRB4J+/Z+clAxL
         1yIuYvITUmhItcLi3UCFSeeN4ixdVOkhjodfTV9rW/QV/Rqyi7JYroeci+UyhdQOlp
         nf2EFtN88B5EYE8lQ0HPBLKID0dVcoVt3/jnEDCY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N33Ed-1mtdfH3wGz-013NMO; Sat, 18 Sep 2021 17:05:19 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over open coded arithmetic
Date:   Sat, 18 Sep 2021 17:05:00 +0200
Message-Id: <20210918150500.21530-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rc9p4OaTbEa8/RXDx8uu1meei7DGGAuUsLO4ulKVim9zhhX+Aq/
 ubiCX63Cuu5YCXYKlX5/ropa+nOsUUvcgcE0bBC6u904gPgijbZEqW9HCZy/9ilXWPyN0vO
 a3zpDtCEHiUDQ4ehEBYqsepRdMXmK2TVSjjZfRKap2LQv01bT9SBqI7aI9lahqKQgji0D6B
 qpVRVS+/9yU7yXLy11R1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j+pkyp40oak=:N8XrJMxklZIN278tDejCIy
 nVkwX2OtECRXKUsO3ux0wLTlqcxrKtlvYUriG1FvCsXUghtZVEfOnd7uL1TVtPi4wSMbzV1FD
 l4t9/ZKDC3DBNQu5wdZXQDpm5B6IX9iIpvC9yqywAmPKlUIkevdpJfWfHTSIjbwaiy4FaCouS
 +CH+oQRf4tetr9IZSgAJZJWiyDvwkfCkqKAe1b8MjdhhPGYUt8A0y+wDlH65kZDl1gCDpHvFI
 w/TEE/gQpUh/OPFGBA5P8o1svDH2gsMDnw8hn/g7Zv1Ayu0An9KH9SHsnC+hdB1UclAcpQtLc
 OPUhRlwL1ZuaHTSwLB3oHYuQZnbUe4OHIaxIXkiOmBfT1o9rHZ3r5SgjgFnbD1OVEKtqMlORI
 l/56ho4KIwWEkH2UQ6StLJak09KFGnZz6caxmqvF2xT5MvT6beF93UXhMEpXNGrY06Xv1lJbi
 41QtazeDcSkQJdSNnIoy5EP9rLAM/73DdGUwkR27nk4iwZdWC4PigMUvxZ+G++xFkrk+3gfim
 UyORl5O0x3dH3qLtns4lhn9Cb4iRgpw6iMbB8YVnLbzrbxtuOZ1Y9obp9HOAo2L0Ew05jevDB
 hR8gY74R9ZS3p3jpi0c+Y0XKQ74MI38eHFAen3+S1I3lLDbKosyixeLsN5KFVRHrAMyQTQKuG
 53JNIPU7qgRCJxNn5FJq4P+1yCBM7auA+J4aDDyAAI8NhLzuYXB1X7+LUSPub7JIc9lzbbAFQ
 LKRdvsECE9mu3x7O5R1gGbhpjJ3unJ+MQFLX0auwKimZkzWD1py/9S8oaNDN5daLaqJGC4uC5
 rtQD4JekCPOo89rtoc5fYzT7UHVcWSuy+JZYGeOFHunG7P5zVBj+g4WM6xXEPDZ11LgwpmMDD
 CRFqHQgBu/BSgVAN74SJzRSubE055M9bPelIRMjRzHUO1b0E+aHuWWF8yoKhCl+OgSbhVlSNY
 BjlFlRBg7hTMN5YfmaX9stN/4lDDzXfLb1hCKGBevCkHc1m9g1R/mv/vdR4TyK7WOIRdgMHMz
 N1q/3DkVibGaEdoeXpLbVq0qp6EN8VXfwy5az9nHwjA8zwZJpHeACjskId91H5IN2lDx1evln
 Rk256vCuJh/lXg=
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

So, switch to flexible array member in the struct attribute_set_obj and
refactor the code accordingly to use the struct_size() helper instead of
the argument "size + count * size" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index 50ff04c84650..ed0b01ead796 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1008,7 +1008,7 @@ struct attribute_set {

 struct attribute_set_obj {
 	struct attribute_set s;
-	struct attribute *a;
+	struct attribute *a[];
 } __attribute__((packed));

 static struct attribute_set *create_attr_set(unsigned int max_members,
@@ -1020,13 +1020,11 @@ static struct attribute_set *create_attr_set(unsig=
ned int max_members,
 		return NULL;

 	/* Allocates space for implicit NULL at the end too */
-	sobj =3D kzalloc(sizeof(struct attribute_set_obj) +
-		    max_members * sizeof(struct attribute *),
-		    GFP_KERNEL);
+	sobj =3D kzalloc(struct_size(sobj, a, max_members + 1), GFP_KERNEL);
 	if (!sobj)
 		return NULL;
 	sobj->s.max_members =3D max_members;
-	sobj->s.group.attrs =3D &sobj->a;
+	sobj->s.group.attrs =3D sobj->a;
 	sobj->s.group.name =3D name;

 	return &sobj->s;
=2D-
2.25.1

