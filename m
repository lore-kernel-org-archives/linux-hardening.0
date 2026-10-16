Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947753E312
	for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170279; cv=none; b=hPrj4Q7ZA6g0nwsazjzi6p4odzp2RPiJw9DXtY90OHfXdrwRY0coop2c53nFtPoIBE/fhqO9tjDL+zmpDqRZV5yRtCwV9UNZybb/hK9mqnVqDqMfq0wp4tTrm4WjeM/2Tc5eDJJUCA8tQPm2p34tcRNLP0qH2ndILxJqsT2lX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170279; c=relaxed/simple;
	bh=VgahlXi9xQXwt4JF4mMbufVALOGlgxUt7D/A/d7V4Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2K6pINYOTXgkFDQn6rMhRUj4BkxQ/S1zw6cIrJ8wAN2UBktOGXioWo2rDTkec9CSARN53dbnQ2vLHmepxgOcw7qAkTX8Nr2f9Sbqz6QiB+2VZKg2EOWupFHsRtsH2Bj62k7QOhvDaJdM8SPLVPEYCQ0HSts6pdPtFlf/sa4BPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=batON7ge; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="batON7ge"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3ac92391681so64481a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170277; x=1792775077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4NgL+ojrdgYlUbFZkcvjKq125dB+9KfHPFlmlvMf/b4=;
        b=batON7geBarKT3rCKiQn235Xk8L7BQPNtxWItSqOwETyyu++CqDs2gbEQc7JzUqkpc
         GhoD7EeSl/1HgbzuBC2BNGXXn0BxTo0htZvNWtTHEnRulX1NDHX5JS+3DswhEtYdVowF
         WtFcDMTv/4qxlpHOUuCkV9CTq7JqsC1pM5WLfVHx4fZJiNCWEl+p4ZgjkDuU0k7917b5
         ZuzvvupvF9+SaU4h1uK3nBQvoM6pcrmFfQl6dQsVn9wZkhtEFtRj7qhika0YiXaHeFrA
         WB8G8qULPCvWNWwM2GeFOi3JYQFscN/BffRqk7VmoF3YDSNyk4086H990xhztm3Mrt5d
         ZIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170277; x=1792775077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4NgL+ojrdgYlUbFZkcvjKq125dB+9KfHPFlmlvMf/b4=;
        b=K7EQ4gSOKRhYKkCgUWBEXQx4V086sezc0rhKTlwRcGk4pQ4WrsJhOyqHcYspOZpDfJ
         zz1/D4ONgD6cmRi3BOUMAnD3RnG5HTam5PpLAxRX7tXwtR6TaQv8IaB0db/mqx4pFOW9
         lndLjZPvNLPs4DtLwOSE/Fd6rSe0vAf9hr7AoiYhG8ZSLItMvN6SpkZUFh+yVsfzaoFE
         rKWl20inEK9lAmKgmXDh+04AKoSJ1vrgqop8kFWFYh4XZoSdP5Es3aH9zn1tqyEJ2dBl
         /NX0uzheqOOs4jEOM594H+QptAdNFqC++e0Q4eMTanT5+It8H07XS7NM8xj+gzC1cgwd
         7o6A==
X-Forwarded-Encrypted: i=1; AKwUvBwhK6K4WSgsOsJssDBq10BJdxje+0mfcZPJ6dAjDi8KzPckuceUUjS8Y29vurvsBNtCRe206wsE+mPRzNo3PuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuazSYqd/WA4BVQUy76kvssbF7uZYvmYOzZmV9M7PWjFOfZEjK
	QtIe+TB4klPJpUvaz1cte90DfQ/NyoJo2CGBS/D5MnQhey87pTm11CbNeHA319ETEauAxKj+
X-Gm-Gg: AYBFou0+iVp0YY405ksCg9AMsuF5aX4WhOxC3OquX3OeLhd4tR3bmmR0Lu1G+V8/kqN
	WfvnM6CM+E3L/X56jrrCUurMeKlsyUYjqlqPtPmcfiDsXePu8LVIh08veryQkUToGZYgVv9Z5fZ
	OivsSqY8uF+/a1H2GOkcmnNOmTqdlTR0nyyOlBxMNTQueHNx8kY7C4y8ZL50AMQLgDgu7we5sJJ
	b6HsFYMfdQfI2grzoW05/IPZiu0iWJIPGUTTUB3/j17YavEaJkIl9hPmqImhim8vIoMuSF48QK4
	R5X+oL97u4X/9yAxIyQ6G/YNpSdWoI+7nFkVp5K9mnWHPjxDCL1rj5iyobt6cI11Ox/IBqHUyNr
	dnsc/LD5REtXgZ06roKb5AMZWXodzqCTOnIa4FdThCDF0PCdeD3M4LBvno14Wyr8muOCsGXcNkc
	zJEUKtdt1eK9APkmd8NCweipNYvOJ/WUErRDb6XbaEE7wiBifd1YmkLfT/TOX1poKry7HYJALwq
	l6O98/xiamZ/5M=
X-Received: by 2002:a17:90b:390f:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3aceec24c11mr399807a91.21.1792170276595;
        Fri, 16 Oct 2026 10:04:36 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:35 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH 2/5] Input: misc - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:08 +0800
Message-ID: <20261016170411.51025-3-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016170411.51025-1-shlomojune6@gmail.com>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ati_remote2, cm109, ims-pcu, keyspan_remote, powermate and
yealink drivers build the physical path by appending a constant
"/input0" suffix with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/misc/ati_remote2.c    | 4 +++-
 drivers/input/misc/cm109.c          | 4 +++-
 drivers/input/misc/ims-pcu.c        | 8 ++++++--
 drivers/input/misc/keyspan_remote.c | 4 +++-
 drivers/input/misc/powermate.c      | 4 +++-
 drivers/input/misc/yealink.c        | 4 +++-
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 8db2dca84975c..929163f52177e 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -767,6 +767,7 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 	struct usb_device *udev = interface_to_usbdev(interface);
 	struct usb_host_interface *alt = interface->cur_altsetting;
 	struct ati_remote2 *ar2;
+	size_t len;
 	int r;
 
 	if (alt->desc.bInterfaceNumber)
@@ -823,7 +824,8 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 		goto fail3;
 
 	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
-	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
+	len = strnlen(ar2->phys, sizeof(ar2->phys));
+	strscpy(ar2->phys + len, "/input0", sizeof(ar2->phys) - len);
 
 	strlcat(ar2->name, "ATI Remote Wonder II", sizeof(ar2->name));
 
diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 353d3c1d347d5..d3aee3c498702 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -685,6 +685,7 @@ static int cm109_usb_probe(struct usb_interface *intf,
 	struct input_dev *input_dev = NULL;
 	int ret, pipe, i;
 	int error = -ENOMEM;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 
@@ -766,7 +767,8 @@ static int cm109_usb_probe(struct usb_interface *intf,
 
 	/* find out the physical bus location */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	len = strnlen(dev->phys, sizeof(dev->phys));
+	strscpy(dev->phys + len, "/input0", sizeof(dev->phys) - len);
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index b1a0edcc49b4e..697813fb11da8 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -205,6 +205,7 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
 	struct input_dev *input;
 	int i;
 	int error;
+	size_t len;
 
 	input = input_allocate_device();
 	if (!input) {
@@ -216,7 +217,8 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
 		 "IMS PCU#%d Button Interface", pcu->device_no);
 
 	usb_make_path(pcu->udev, buttons->phys, sizeof(buttons->phys));
-	strlcat(buttons->phys, "/input0", sizeof(buttons->phys));
+	len = strnlen(buttons->phys, sizeof(buttons->phys));
+	strscpy(buttons->phys + len, "/input0", sizeof(buttons->phys) - len);
 
 	memcpy(buttons->keymap, keymap, sizeof(*keymap) * keymap_len);
 
@@ -286,6 +288,7 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 	struct ims_pcu_gamepad *gamepad;
 	struct input_dev *input;
 	int error;
+	size_t len;
 
 	gamepad = kzalloc_obj(*gamepad);
 	input = input_allocate_device();
@@ -302,7 +305,8 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 		 "IMS PCU#%d Gamepad Interface", pcu->device_no);
 
 	usb_make_path(pcu->udev, gamepad->phys, sizeof(gamepad->phys));
-	strlcat(gamepad->phys, "/input1", sizeof(gamepad->phys));
+	len = strnlen(gamepad->phys, sizeof(gamepad->phys));
+	strscpy(gamepad->phys + len, "/input1", sizeof(gamepad->phys) - len);
 
 	input->name = gamepad->name;
 	input->phys = gamepad->phys;
diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 70cd6586459ef..f0f31f2823d57 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -430,6 +430,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 	struct usb_keyspan *remote;
 	struct input_dev *input_dev;
 	int i, error;
+	size_t len;
 
 	error = usb_find_int_in_endpoint(interface->cur_altsetting, &endpoint);
 	if (error)
@@ -482,7 +483,8 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 			 le16_to_cpu(udev->descriptor.idProduct));
 
 	usb_make_path(udev, remote->phys, sizeof(remote->phys));
-	strlcat(remote->phys, "/input0", sizeof(remote->phys));
+	len = strnlen(remote->phys, sizeof(remote->phys));
+	strscpy(remote->phys + len, "/input0", sizeof(remote->phys) - len);
 	memcpy(remote->keymap, keyspan_key_table, sizeof(remote->keymap));
 
 	input_dev->name = remote->name;
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 754379d2625cf..dbf9f06f3059e 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -299,6 +299,7 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	struct input_dev *input_dev;
 	int pipe, maxp;
 	int error = -ENOMEM;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 	if (interface->desc.bNumEndpoints < 1)
@@ -334,7 +335,8 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	pm->input = input_dev;
 
 	usb_make_path(udev, pm->phys, sizeof(pm->phys));
-	strlcat(pm->phys, "/input0", sizeof(pm->phys));
+	len = strnlen(pm->phys, sizeof(pm->phys));
+	strscpy(pm->phys + len, "/input0", sizeof(pm->phys) - len);
 
 	spin_lock_init(&pm->lock);
 
diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 560f895a00cda..1a3bebc8c3513 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -812,6 +812,7 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct yealink_dev *yld;
 	struct input_dev *input_dev;
 	int ret, pipe, i;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 
@@ -891,7 +892,8 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	/* find out the physical bus location */
 	usb_make_path(udev, yld->phys, sizeof(yld->phys));
-	strlcat(yld->phys,  "/input0", sizeof(yld->phys));
+	len = strnlen(yld->phys, sizeof(yld->phys));
+	strscpy(yld->phys + len, "/input0", sizeof(yld->phys) - len);
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
-- 
2.43.0

