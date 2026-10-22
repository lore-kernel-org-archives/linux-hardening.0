Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653003;
	b=FyOsNV1jg6rWHzdHXNDW+XtwggFj03CW79nZq5TJL/52+BHCbGOzsGkgOQtuMO6rGNAg
	 SAYsastadhU/gMdtvvuzYPPIn8kFBi0ovBY4m9xwe4sStIy+tjvKFL9MnyaQ7fCe23Lpx
	 lqNt2dru0f4pghZqWnA5zOU4JiEqc2ZK2MvmEdBnE7Fi9IEKg1Z4q4E8D4tdI/V7wP+11
	 j8f4maNQc2d/DTg3DZsCaaaDMzng9WfKjg8ysCix0kzf7ufEgqqaRkbtCEm+tSUhrWZZw
	 +wImMiPiAeHPJm5HGkF3wAtd9X/8R+MF2wrA7mkfhIDOR3tpGUBQxV4Ar3fWNQSft4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YNbSVMz9CVaFMRMcwXe+rNEhXXF0h4y5O/CdVjdd2qA=;
	b=eLWeSJokLjv+Yq73UuyQFh3I6hX1TzPcPsIexgl18t5DepjXEDjMENtbPTnfWGsYieML
	 lPes9496/7nfhM7dBE0E+YjypacYGmombG9zBz+Lh7pTRX9FN2hZNuCURiyzvYffBlF0y
	 G0KPjnHMAyru9X2TEY0m+NdDKPZSNOeJp1T2OfHwBbuq9AdrwvqSS0NEQL4AbzVoOuj4g
	 v17AU+xV0H3Q/ijtrZUg2XXDqxuTGPQsNf1ue4rphJ/mjozyI8+8C1gfbBDV0MyBCEgoX
	 Yw28ftgBHy0u2bG3sfYn/nDHfTcMHuNgXLiPoZzKAYhv5KpYpbHG1i97KQ6sDuAl/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="FtcP4H/w";
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F4606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D4F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FtcP4H/w
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd60c90a67aso144287a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653002; x=1793257802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNbSVMz9CVaFMRMcwXe+rNEhXXF0h4y5O/CdVjdd2qA=;
        b=FtcP4H/wML0Ve6irDqNV4IJmnpuz0MCvhXyb1NxQZlnhXR4rLTgA/4cPOOWQ31YPeq
         ucPxwr+nApOBm2kpNwf9OmcEULe19Q9ftbdqLBxoQ4afNoi6PA1XGV+yxI/B0EquYgKu
         4L5ofyVTjiTwJeepKEYfWNnEh8jxdC6YoumO5NBeHmBqQrGtmW/yd2gpgc97OUDsqh8H
         Xlu0wyPDJR1RqFhLmRLxkY1lZ1H+HlBl7qqpbrub1ZTn+186t0kqP7V31OiwHK0zOKQx
         MmQFqixB1V/foZAZQd/7Y/BVugTh7OFQmkv0aHy8C6FaJ/m6s989yhE9K73XrqDcVdDQ
         OnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653002; x=1793257802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNbSVMz9CVaFMRMcwXe+rNEhXXF0h4y5O/CdVjdd2qA=;
        b=tD03UY7f6PRpeT+BqX4uNvlwY9t2L7OlBhKoK+TR3MjmawtNVPuQV3whwYJam9yDoA
         tO6tG/yEPTRMZRN0lzGIunkeYLbHZM6y45ifD8JN1IUs4Rjfvs3IiH/ngzb3CuD8zjTB
         HflPUvYkWocs1yweWATD6iuzk8VNRskQVu9q0EdGeZLbR+TuO5znRhSAPuG5dIBfUnnz
         tVQ+k10FAHcQrw5IkhCfQKtn4LphOHEfPsVA9KdUHKE2grvxu9suZaXEAfvNgzZKOXPf
         anUyhl7arOypr6aEOKOZwFO91Q+tghdZtFkA+kt68688kUQlCyP3E60Vmk8XIM1MG6Zo
         kxvQ==
X-Forwarded-Encrypted: i=1; AKwUvBw07I1dVV3uihTBxQT61F43vDI08I2E8+IO+JlRJvtRH6ZqVZ0owv6iY2mhp9pqcf9rSU/nbX5tmSNiZVd8Ppo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzMhAoWHGHLisWgOsWh1XVa3ePFoCVIKXqbOtOAw8eeCNXH3kz
	uwhLcGTuN2Hdqs2JRGi0yobNJwIMoNpHOsdOYvYXduAlM10lFYqkEbjwu4M7dBSK0bwgVQ==
X-Gm-Gg: AYBFou1VZiAFRztKwtVV10CCv64Q4RIOZ0PtQ7urIghVv+LoVmRKBJcB+AKlfq1zB5b
	fXbG+wqRQIcBv+wqswU8XcX9mjQ7HH4tlDoV0DwnxwaMkuqJsvvPCZRmsysqUHYrRgqpo8M4500
	Qxh1ET803jqTotJLkZ8vDIKV4Y149st+ie5+WzWp+MgPjpAGY9huNpLdNgDCvELPalhczJ3fPK0
	KUHFYysLnqs6DfpnK/TgRKrVVPgeeeB8jqepoda+nCGC2OSWy0qaKlye+BFn8vR3tSMquCHF2p8
	u9+A3wHtdZn7+EjZuIO7v2YpQra6WHQUqIgyuoe+N7sPaPJGrou8WoV819nuRfwnOMQzhGcgrS+
	B/RAxbMs6HinV93b3dho9vIYK70DDonPWbsnrZxRHKSWU4BWniz9H6ESDSW7TNCTLy5ycCLT2F4
	8UL5ovWeA1MpcVfRIDhQAeOyyMyCQubrIamdHKLZNSu0rDPhROnj07JwBKkubUVDtKn1g0oKc1Z
	b498y7xp+llyMzu4eo50kkhSYjccATjF7ca/ier013RcjB0nYtxPmwHzE6KPbmCAXPv2nnSUg==
X-Received: by 2002:a05:6a00:23d4:b0:881:8b53:f64 with SMTP id d2e1a72fcca58-8a089facbd7mr3250979b3a.59.1792653002200;
        Thu, 22 Oct 2026 00:10:02 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:01 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 3/6] Input: misc - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:26 +0800
Message-ID: <20261022070929.20820-4-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022070929.20820-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
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

