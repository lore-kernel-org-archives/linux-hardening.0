Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585927;
	b=Nigc0wBjH6jeAue6QeQ9MHG1AadfsAmYLsqDZnydkTzEmvpotNEdBMGSCwZva3vR84CD
	 BgCq6AA6kx9CmDgL1xqQIRwXbNp1/jiFyM7TFcztMJFMe0dLjr5tKuyaClhnUD7Bnw3he
	 Y7QhtpCg3tp2GWMljYbaqdENTiZi6ruljcEecQgbyTcXPDQuC24A72nuC09evZ3h3F0WE
	 o3Rx/kEvr8QrSKhzuhkdR8FJAFphUo3rPgr1HTMFXBgFH46mWjYoIKOgDP4fgYlK+zrLz
	 WoAMlV4qCQbfUc9yIniiGer4s3RecuPbTsuUyYAV7Ofdth+yrTrV8bShn/OMSeTstTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R129GmDUt+qvHZFqEN3VKb8rNuaams87GONxeRw6Drs=;
	b=KxxVBmXztsLt8cjYc9phG5cwDCJx9dRYjHuwPPbswYBlozq/G5IBVDNl49c7po73wsSz
	 AoOxPHeUHevH9sCaUpXfQF0vfhM8VEK20rvUf4WiCHiIPU/fvONNJyXERvII3Mu7fN8zg
	 upLrTQDpujG1Gdpt/5rwG8kYO8HBXpDRv2HO9ZEJAA4t7u5zDF3Hy3F1VBaKT1SIBNmLV
	 SGIcLBEee+RRJPfLkDFl/NOoe4gQ7y3hhjA3208EFr1vXFxg1BXrjMWIT9tp3N7uHlbww
	 3E4SznrKaIJ7N7uz2Z1TkLUX6mmyatVCmMiFbXrYewzwUG32Aj9+hUKG35/FsWLz0zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dS6XanIC;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3191260A3802
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3191260A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dS6XanIC
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad41dad3faso478862a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585926; x=1793190726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R129GmDUt+qvHZFqEN3VKb8rNuaams87GONxeRw6Drs=;
        b=dS6XanICxAcG1TNmiPkCDP2CLwUc/8j9KXXD5drfyueKCkrOYq1BY2HJea2ekENFAU
         PDcGmH9VRXQC4BnXkyQuc83pxrsu/kYm6BE2f4ME/LYnzp1y25EifzkVf1MbavVmuvEG
         UZEbwp2qNQ7yKK2ZYd+43L2nkl5ROM8QdEAniDRGk/7Gk21nSiGzJ6ouDqF2/X+CThOd
         C4acm+q7acwdepGv8DaJ53mVxigcrBPJCn/7dYmCbSioWlBS9CHOh41ZIbsjgS16/TmW
         x6tBV2oh8xxH4W9W9nKj7BWbUlRUVBALw7c1emP01fd/q30fVT5d7okF2YuoTeCzMhDc
         JWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585926; x=1793190726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R129GmDUt+qvHZFqEN3VKb8rNuaams87GONxeRw6Drs=;
        b=DubuwqhugqOBfq5KnBdy21RIVSIRXmJH/ImUX6Xe6agfjTsl4+h9HVhpRYs4+PnyPn
         f0qv6lAMuFgI5b0Vpu2txaPnljB5755glEqljexlENuGPzDXNKv01ZCUjGnFdGg2OGi3
         MO31noKMjnAIlDmAqONby810t4wkc5iw4pA1VXNiZ2BBcgm9UCi+SEJRPt8K7TnULe89
         NvYFB0DSQ4T5R58Jh0tHC7pQWBYxUTyz3VYSgyldr35QoDoIXBMSX9/Dactp1FSL78Fu
         Is+rcKVnb/lIn7oN2FkHHLw1TXd4sxNKNOvQruuEC9w+5fVJzU1jz9SSupYDcNrAesie
         EtUg==
X-Forwarded-Encrypted: i=1; AKwUvBytGNLElHW2/IG46cVk7U7S7XHYFrEEdfFC2OQD7NDoh4Da8rDndTDZm0vxJAXXvmPvFzjbRG2/bh9Hhi1SNCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAX0u78OCg6TUhr9yTTEgZ9uabQDGUmmjNgMWk7sa2+WEQk80K
	23LnstGO6f3jWz5lq9Z69TvTpCW0VPpD+FnVtx3FkTUOaNvLNlQ/U53x
X-Gm-Gg: AYBFou1ch2WvtoOiVsNym7OelYvtuGbZfoBZ44s41rymJ0DRtokueVF6G0tEjndLFLM
	ozfh+Q2OtYNkgE7yVfADyl7RjlV1j/wIjjhDMyhmJX2qOVJFtXdOdvxh7Bl/0I78y3T78OFWnjs
	8p8ly1j6n4Sd4yeJ8GtxAbnXLTOP3aKGV6bKApjVYk2Oa2FUGA8jVikm4sJbuSExXux0Wiwp8Qi
	M7OL9JgBa88x6qvmLxeK7z1Wd6TRMiXDKO05lp3TefwXLke9BWdHr3mgMuTh7EOIPf8Ln41a/yT
	gP2ydjQAN5Bc1CS0fe7x+bdrsYOWqg9QwXyZMoJ48vx/7AdtwytCuQGGMMqLh8TpmWWLReVd0mg
	tIx6eXnkqoH/pfAbI+QTnFoUtItPR/7mIs+j1KP9aExyZHUrAz8ZKjm6FNWWc0dqo1XYQM7Gqck
	2JBsnXrZt4AxJ0rLVMc446WH8M8SemlBaenJjI2sS4fuHworwsZFU0Xg5x1ZHivVsS786J3ular
	f/L71pQrscUhb2b3QTgIXdacI+8XkekNTHGrJfsddTs2FjnRgG/JGRRxroC+jAzmWomjpgVfg==
X-Received: by 2002:a17:90b:5547:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-3ad86ee2cc9mr1596337a91.18.1792585926342;
        Wed, 21 Oct 2026 05:32:06 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:05 -0700 (PDT)
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
Subject: [PATCH v2 3/6] Input: misc - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:43 +0800
Message-ID: <20261021123146.17202-4-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ati_remote2, cm109, ims-pcu, keyspan_remote, powermate and yealink
drivers build their input device physical paths by appending a subpath
with strlcat() after usb_make_path(). Most use "/input0"; ims-pcu also
uses "/input1" for its gamepad interface.

In preparation for removing the deprecated strlcat() API [1], replace
these pairs of calls with usb_make_subpath(). Pass "input0" or "input1"
as appropriate so the helper constructs each physical path in one call,
avoiding a separate buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/misc/ati_remote2.c    | 3 +--
 drivers/input/misc/cm109.c          | 3 +--
 drivers/input/misc/ims-pcu.c        | 6 ++----
 drivers/input/misc/keyspan_remote.c | 3 +--
 drivers/input/misc/powermate.c      | 3 +--
 drivers/input/misc/yealink.c        | 3 +--
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 8db2dca84975c..20cb7b8efcc0b 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -822,8 +822,7 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 	if (r)
 		goto fail3;
 
-	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
-	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
+	usb_make_subpath(udev, ar2->phys, sizeof(ar2->phys), "input0");
 
 	strlcat(ar2->name, "ATI Remote Wonder II", sizeof(ar2->name));
 
diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 353d3c1d347d5..06d8f0dab4b37 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -765,8 +765,7 @@ static int cm109_usb_probe(struct usb_interface *intf,
 	dev->urb_ctl->dev = udev;
 
 	/* find out the physical bus location */
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	usb_make_subpath(udev, dev->phys, sizeof(dev->phys), "input0");
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index b1a0edcc49b4e..e629a327fdd76 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -215,8 +215,7 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
 	snprintf(buttons->name, sizeof(buttons->name),
 		 "IMS PCU#%d Button Interface", pcu->device_no);
 
-	usb_make_path(pcu->udev, buttons->phys, sizeof(buttons->phys));
-	strlcat(buttons->phys, "/input0", sizeof(buttons->phys));
+	usb_make_subpath(pcu->udev, buttons->phys, sizeof(buttons->phys), "input0");
 
 	memcpy(buttons->keymap, keymap, sizeof(*keymap) * keymap_len);
 
@@ -301,8 +300,7 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 	snprintf(gamepad->name, sizeof(gamepad->name),
 		 "IMS PCU#%d Gamepad Interface", pcu->device_no);
 
-	usb_make_path(pcu->udev, gamepad->phys, sizeof(gamepad->phys));
-	strlcat(gamepad->phys, "/input1", sizeof(gamepad->phys));
+	usb_make_subpath(pcu->udev, gamepad->phys, sizeof(gamepad->phys), "input1");
 
 	input->name = gamepad->name;
 	input->phys = gamepad->phys;
diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 70cd6586459ef..68c969657806d 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -481,8 +481,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 			 le16_to_cpu(udev->descriptor.idVendor),
 			 le16_to_cpu(udev->descriptor.idProduct));
 
-	usb_make_path(udev, remote->phys, sizeof(remote->phys));
-	strlcat(remote->phys, "/input0", sizeof(remote->phys));
+	usb_make_subpath(udev, remote->phys, sizeof(remote->phys), "input0");
 	memcpy(remote->keymap, keyspan_key_table, sizeof(remote->keymap));
 
 	input_dev->name = remote->name;
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 754379d2625cf..f004cfca795ec 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -333,8 +333,7 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	pm->intf = intf;
 	pm->input = input_dev;
 
-	usb_make_path(udev, pm->phys, sizeof(pm->phys));
-	strlcat(pm->phys, "/input0", sizeof(pm->phys));
+	usb_make_subpath(udev, pm->phys, sizeof(pm->phys), "input0");
 
 	spin_lock_init(&pm->lock);
 
diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 560f895a00cda..9a8ee7a586f44 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -890,8 +890,7 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	yld->urb_ctl->dev = udev;
 
 	/* find out the physical bus location */
-	usb_make_path(udev, yld->phys, sizeof(yld->phys));
-	strlcat(yld->phys,  "/input0", sizeof(yld->phys));
+	usb_make_subpath(udev, yld->phys, sizeof(yld->phys), "input0");
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
-- 
2.43.0

