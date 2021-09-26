Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB5C4332F
	for <linux-hardening@archiver.kernel.org>; Sun, 26 Sep 2021 11:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EADE61019
	for <linux-hardening@archiver.kernel.org>; Sun, 26 Sep 2021 11:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhIZLVk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 26 Sep 2021 07:21:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:54309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhIZLVk (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 26 Sep 2021 07:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632655179;
        bh=LVRo0Nnk3bjO4nr2gf7aMG8qFvqjKKqzRNNSdnXJkfo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=afdm/8MG5hhgYnMv2bjj/FfhjjZL+XPwyEIL2IwkU5akDegQkbH1hG8xZYFTFurBc
         TYuRYQiGN4R0vxkwAAujrCsAOLR9rqzPdTSNTtSiBA8mkKBJypCWk5935zTGAyuhqF
         HA6ZtPsUxE+O++UFGBdUy33rIdy4DNSgX6xkRdn4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MtwUw-1mpQSF0PIC-00uKUp; Sun, 26 Sep 2021 13:19:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: Switch to common use of attributes
Date:   Sun, 26 Sep 2021 13:19:08 +0200
Message-Id: <20210926111908.6950-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qMcOHYkDWaJGnDS2aun2yYXZhumi80fV9nVrFKaIbGOtnT0KvTz
 WSQLhnzsRBqWen19FgYHgcwRzmzmw28uAk4lfqh+pKikM7TKCejCH3gIR4KYyHyzYkJ2bhP
 cdUIxYK35vGwWkAtyRFxGsp/DXyaX5GBWKNBiUQPDEWBieQJekGnSO08KnxQVbGZzniFD06
 xyuJSp/7XEzKRIS/j8ozw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zain6EwAHX8=:+iWBDos79qtSXaAHEcP/er
 1lFNKMExOxR4kfXV73/pB+lvn5trlBsuWYh++ccwFSP6/ayRtOPpHyVUt1pBwuFIllWwUamrV
 Evwix0gmd6QBNhoKvcvsetZ8M3h/f/kG3BHeJc+F/Zn4/IqOqEgJTWD4MdGyu+qVydYHrAa0N
 z3O3paB4N9m5VCziB3Pg3VDfW2CbHIniS4uYcAnYL2S2961BsOc1/8vDiGuVf/Cpy8HqdJUp4
 3EFTjoHv59NYUKvj4Wfkmof4Vca/iqR9dso+vEBdpNseMe5USe6Io1Tpl2Am11/wJZvAmk0FB
 8hkdUkgJNYWMlci5JwniobvnqgeXtvACGzFxv+agfsUqkVIv3WcbBrUYFSBPRObK7aaqwRwWy
 Mb9Xke13/GLcK+fJRPQwEquKDbt63QQmL3AKEOzJCHHy7LuMxZmInhzjmN82F5VJsXGYjgZVK
 TyYmgJ7ZTap3n2JqU5gTRnVhubLJ48+t5kD1TOsrSGjXzvttNxX8ejeeTp3ECJ8aZM2Vt9gsW
 lP2X09u2qDYK1ZXXi66CbI7jWxMpkjBDHyvV8vukcz/Pe6GQTbuUNFZgZ/9xVo1rzhAnNH4PW
 w/QUoN691kNv4T59kvEe//vmthyAZIT5Go55yJR1bkE2tQhjgZdNdCicIjEhICI6gaOAP87wG
 AHgpmUuwZLn0Su9oXuh8GUXlcUdD2VRC2itT33MmN/9keMaJE1Qc0kSCahgXPcD3s+5OsnSuI
 WC60TiD3m6AXTsxJH91WZip/umuLL0VMYvgCIXBVok6oswQDoqLTw7IWdur3S4i5yqoUNVPQZ
 nXmNUXBDvFwh5kODjUw4AG+HTZwmZX0+a5/StbfT++UEBFGkGNURh6uUWdL+Trgnmm+wkHenR
 nW8d3Nt/t5+f3RDFlmMG5eI487++DmG/YRlY5VICAzW4R/kSMTtTuZ5lRRpQZG5bykwbOFSU2
 3Snq2Kl/sMv8nCHi+hxtPFxxqzMjbhAnvmTaLJYxS7w/316R15La5V2/1mukyL9myTZKc7Nn4
 /7YVn2F+Rx/IvJTsQVubG7IdDyedfSws4sLtQgba4PCatCcmb9ed3gCsyHrxg96HqGhb5FH0u
 JTBhUO3En8g0f0=
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

So, to avoid open-coded arithmetic in the kzalloc() call inside the
create_attr_set() function the code must be refactored. Using the
struct_size() helper is the fast solution but it is better to switch
this code to common use of attributes.

Then, remove all the custom code to manage hotkey attributes and use the
attribute_group structure instead, refactoring the code accordingly.
Also, to manage the optional hotkey attributes (hotkey_tablet_mode and
hotkey_radio_sw) use the is_visible callback from the same structure.

Moreover, now the hotkey_init_tablet_mode() function never returns a
negative number. So, the check after the call can be safely removed.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Hi,

Following the suggestions made by Greg I have switch the code to common
use of attributes. However this code is untested. If someone could test
it would be great.

Thanks,
Len

Changelog v1 -> v2
- Don't use the struct_size helper and switch the code to common use of
  attributes (Greg Kroah-Hartman).

 drivers/platform/x86/thinkpad_acpi.c | 139 +++++----------------------
 1 file changed, 26 insertions(+), 113 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index 50ff04c84650..07b9710d500e 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1001,79 +1001,6 @@ static struct platform_driver tpacpi_hwmon_pdriver =
=3D {
  * sysfs support helpers
  */

-struct attribute_set {
-	unsigned int members, max_members;
-	struct attribute_group group;
-};
-
-struct attribute_set_obj {
-	struct attribute_set s;
-	struct attribute *a;
-} __attribute__((packed));
-
-static struct attribute_set *create_attr_set(unsigned int max_members,
-						const char *name)
-{
-	struct attribute_set_obj *sobj;
-
-	if (max_members =3D=3D 0)
-		return NULL;
-
-	/* Allocates space for implicit NULL at the end too */
-	sobj =3D kzalloc(sizeof(struct attribute_set_obj) +
-		    max_members * sizeof(struct attribute *),
-		    GFP_KERNEL);
-	if (!sobj)
-		return NULL;
-	sobj->s.max_members =3D max_members;
-	sobj->s.group.attrs =3D &sobj->a;
-	sobj->s.group.name =3D name;
-
-	return &sobj->s;
-}
-
-#define destroy_attr_set(_set) \
-	kfree(_set)
-
-/* not multi-threaded safe, use it in a single thread per set */
-static int add_to_attr_set(struct attribute_set *s, struct attribute *att=
r)
-{
-	if (!s || !attr)
-		return -EINVAL;
-
-	if (s->members >=3D s->max_members)
-		return -ENOMEM;
-
-	s->group.attrs[s->members] =3D attr;
-	s->members++;
-
-	return 0;
-}
-
-static int add_many_to_attr_set(struct attribute_set *s,
-			struct attribute **attr,
-			unsigned int count)
-{
-	int i, res;
-
-	for (i =3D 0; i < count; i++) {
-		res =3D add_to_attr_set(s, attr[i]);
-		if (res)
-			return res;
-	}
-
-	return 0;
-}
-
-static void delete_attr_set(struct attribute_set *s, struct kobject *kobj=
)
-{
-	sysfs_remove_group(kobj, &s->group);
-	destroy_attr_set(s);
-}
-
-#define register_attr_set_with_sysfs(_attr_set, _kobj) \
-	sysfs_create_group(_kobj, &_attr_set->group)
-
 static int parse_strtoul(const char *buf,
 		unsigned long max, unsigned long *value)
 {
@@ -2042,8 +1969,6 @@ static u32 hotkey_acpi_mask;		/* events enabled in f=
irmware */

 static u16 *hotkey_keycode_map;

-static struct attribute_set *hotkey_dev_attributes;
-
 static void tpacpi_driver_event(const unsigned int hkey_event);
 static void hotkey_driver_event(const unsigned int scancode);
 static void hotkey_poll_setup(const bool may_warn);
@@ -3089,7 +3014,7 @@ static const struct attribute_group adaptive_kbd_att=
r_group =3D {

 /* --------------------------------------------------------------------- =
*/

-static struct attribute *hotkey_attributes[] __initdata =3D {
+static struct attribute *hotkey_attributes[] =3D {
 	&dev_attr_hotkey_enable.attr,
 	&dev_attr_hotkey_bios_enabled.attr,
 	&dev_attr_hotkey_bios_mask.attr,
@@ -3103,6 +3028,26 @@ static struct attribute *hotkey_attributes[] __init=
data =3D {
 	&dev_attr_hotkey_source_mask.attr,
 	&dev_attr_hotkey_poll_freq.attr,
 #endif
+	NULL
+};
+
+static umode_t hotkey_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	if (attr =3D=3D &dev_attr_hotkey_tablet_mode.attr) {
+		if (!tp_features.hotkey_tablet)
+			return 0;
+	} else if (attr =3D=3D &dev_attr_hotkey_radio_sw.attr) {
+		if (!tp_features.hotkey_wlsw)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group hotkey_attr_group =3D {
+	.is_visible =3D hotkey_attr_is_visible,
+	.attrs =3D hotkey_attributes,
 };

 /*
@@ -3161,9 +3106,7 @@ static void hotkey_exit(void)
 	hotkey_poll_stop_sync();
 	mutex_unlock(&hotkey_mutex);
 #endif
-
-	if (hotkey_dev_attributes)
-		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);

 	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
 		   "restoring original HKEY status and mask\n");
@@ -3249,11 +3192,6 @@ static int hotkey_init_tablet_mode(void)
 	pr_info("Tablet mode switch found (type: %s), currently in %s mode\n",
 		type, in_tablet_mode ? "tablet" : "laptop");

-	res =3D add_to_attr_set(hotkey_dev_attributes,
-			      &dev_attr_hotkey_tablet_mode.attr);
-	if (res)
-		return -1;
-
 	return in_tablet_mode;
 }

@@ -3515,19 +3453,6 @@ static int __init hotkey_init(struct ibm_init_struc=
t *iibm)

 	tpacpi_disable_brightness_delay();

-	/* MUST have enough space for all attributes to be added to
-	 * hotkey_dev_attributes */
-	hotkey_dev_attributes =3D create_attr_set(
-					ARRAY_SIZE(hotkey_attributes) + 2,
-					NULL);
-	if (!hotkey_dev_attributes)
-		return -ENOMEM;
-	res =3D add_many_to_attr_set(hotkey_dev_attributes,
-			hotkey_attributes,
-			ARRAY_SIZE(hotkey_attributes));
-	if (res)
-		goto err_exit;
-
 	/* mask not supported on 600e/x, 770e, 770x, A21e, A2xm/p,
 	   A30, R30, R31, T20-22, X20-21, X22-24.  Detected by checking
 	   for HKEY interface version 0x100 */
@@ -3636,18 +3561,9 @@ static int __init hotkey_init(struct ibm_init_struc=
t *iibm)
 		pr_info("radio switch found; radios are %s\n",
 			enabled(status, 0));
 	}
-	if (tp_features.hotkey_wlsw)
-		res =3D add_to_attr_set(hotkey_dev_attributes,
-				&dev_attr_hotkey_radio_sw.attr);
-
-	res =3D hotkey_init_tablet_mode();
-	if (res < 0)
-		goto err_exit;

-	tabletsw_state =3D res;
-
-	res =3D register_attr_set_with_sysfs(hotkey_dev_attributes,
-					   &tpacpi_pdev->dev.kobj);
+	tabletsw_state =3D hotkey_init_tablet_mode();
+	res =3D sysfs_create_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
 	if (res)
 		goto err_exit;

@@ -3746,11 +3662,8 @@ static int __init hotkey_init(struct ibm_init_struc=
t *iibm)
 	return 0;

 err_exit:
-	delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-			&adaptive_kbd_attr_group);
-
-	hotkey_dev_attributes =3D NULL;
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &adaptive_kbd_attr_group);

 	return (res < 0) ? res : 1;
 }
=2D-
2.25.1

