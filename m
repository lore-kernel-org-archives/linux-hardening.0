Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690359;
	b=PUyzLbZ4qkKdSjqIyIXreOnFBJSsNQbRnRr5bo2Rnb0JWFSdIGFT1zIEzB+m0FVI/mhb
	 sLdBjdKskt10exd8mj6NXpgMk+fnMF/A5fdgsgz9jitAOwk20QbFJxRSWbJMfpX4tOB6u
	 vP3kH03NWF1mit/R1ppKdhG4GQYRA0OsufSKUT69DA9pyQdgd8qTwakc7EhqW4q8fjc+s
	 mLJvwXWspePsEZMeL6Hp2pOejAKDMMWJtvvrSeATL5F/L0b0yWOoykg4EuNGgoUDHLfy4
	 v2O5ohl5zNMZcNj6sIj6GCnqLurJrXdeNDVo/PizK3n0wFi6YCeWDBeN+q4GX57eIpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5TTK5L3C72RVXuyCfPoL1KiCUuBlYM9fSsQ+OoWqJh0=;
	b=q4z4RJRl9sWVqodQ+HP9Fzp3kXXHkxZ/YqGMzJ4xKUcxYoqn1WhRBkqigt0dZFNjZJCw
	 hxCPB1lm7mygkrv4fshMuQEYb4LNwEQw+fhZqc/thttbNjsfGtzcpjc7nR25MmaJwp0QC
	 mudh1z3EgHcI7OzEPsbA08wDLCx+HvxHH7P3wDgSlASqOM539E48ew8rWq/8pJwUmBpYy
	 UpuyOaSaWWhqvgq3Zxw5ji4BYwANkG4wydLGetnmmsEqiL3tOvx01V8Az5SWuKce6KOTa
	 9vvnKWnJ00hRxJ/TqgeYPffrn02Wy4OcBK2bvGWsvRuL+XSsLoqbLUPxS0KtD1IYNkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eeCmVCgM;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C0606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 17:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eeCmVCgM
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso192035e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792690357; x=1793295157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5TTK5L3C72RVXuyCfPoL1KiCUuBlYM9fSsQ+OoWqJh0=;
        b=eeCmVCgMegRCMD7vOlGg+I+VL7pQWFbhxv3PU5KxF6XDa0o7ajmM/7XY1L43p9HS5+
         itOL5APh7mnHzuXNFok96uju1BIDvogoYxKs+LNEoP0KzZqKpZB2h4aJiZfAoVBC9rXI
         OXBa64Ghjhyr3+zpRWSioZQBJ0F4UnFDPvOW8xL1I0c88FZETbuvhll6WKwGvxuDYd/q
         NjLKXl/YgtmD82fvvGg/sJb4Rb4nlhHaEawHymhU3n5L5dc4+7NXPF/gaQzxtJS1htSz
         38lzO8YmLXH2ksX3fpjcSb2gD+VyGT3rVqk4P5zdk3C8pUXkvGTDCmhsvkyUpHkOLD95
         0LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690357; x=1793295157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TTK5L3C72RVXuyCfPoL1KiCUuBlYM9fSsQ+OoWqJh0=;
        b=Uuh0+SZDqiqd+AtLe8xk+FxX8HqkNvfCmtMZYUyRQSEPilzjVuTH7uirzBauKq/Vss
         s2+7cLd9MmGuSkeDSF17Y3a2dAZ+iQ4uyc1cV5MN7YWWfyK1Ujm0IQcU2N4iKqEdJKtl
         A8PclNi4vdNNyTqvvzS5stDbaryPpw3bUX+D0IhhUiPWuZ8QXn+DnLgKblPfYA1j4vWV
         CWQJviZ7wSh6u6oMAhbLi1d5iuVyzU8TXMbt2C7zaD7fS/4yglHEkgX3VM6A7EXJMEXe
         p96IFiB2cxqu9Wt4DzeEOBYTlE+wTc8M2+s85FTo8Rh5Kdxg07HQCiPiZndsMsJqn86J
         yXhQ==
X-Forwarded-Encrypted: i=1; AKwUvByyO8wN4Ab6/SEAK1o/m0h0rnyzqlRn4mZQfl1BMw98Vkp+KoA/avEQewpajawp+RhRWW1fPaDxiIqjWTnRfvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIL/1Ex2TolCY+oijhCPzjk/PSSAt/Rm9dtgC/pvB8esRXEzQXn
	qhJt9FQDrAUHnyAiY2T/SeLsnV+mkeXzXOpzSMruAlYVElaM1zQpG2p1
X-Gm-Gg: AYBFou2QLyTfGu7k/qwK9MpWcHZVIPIVkzRyerr0Pxz2JZu93n2bMUhQyuLQwvzp2Br
	TrR3772LtiTeroBnTUQF6aaloT5T5ea7WXBPrL0WTAomJ4LBaI0oqcq7Z3fYeW3Tfuc0Mwi2tP3
	jq0Z6pm3i6e2zjriNaAKzw08hZcy2aLzMOUVVTzKEnlKxaZBLD1728HPflLW+5dp4Fj2f9TSPYG
	fKSbVRiGLcf5NmvNxmF7VqedNnUdnKXQC10l2GQFAOXuJCaIJ1NCUdZsKVVIFodYWUEZEWL4FaY
	dne4m3Fn90sZNp7uFPr5ePCWpE2eLajZU0D500uCrejXB9pbwBzJgbR01rC2a4v42gkkhjfmhFV
	/PXmRhSWVlFgk6W99exYLg7OzQkikI36Bz5uQJpJ8zz/xxzcRAR7IqD1XPa6S+AqXNAIvUS6ILa
	8m0v1iC0G3BNeUTZnrb6frwMdHY/ncbjW7RbI/I82RIL+dqe3zh4Tk2dlAK4Gwwn8Kf5yT6SkGN
	YMInowZ45cxVD8kWMCoye9cdfI/Yf3fAY2aaKgTXYoRk3bniWOoAt3QaoopHydfnNHPHgPSLj3r
	zE3ixLw=
X-Received: by 2002:a05:600c:8b78:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4a20cbec0d1mr26844975e9.23.1792690357003;
        Thu, 22 Oct 2026 10:32:37 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0d4sm13857279f8f.13.2026.10.22.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:32:36 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Joonhoe Kim <26rote@gmail.com>,
	Daniel J Blueman <daniel@quora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>
Subject: [RFC PATCH 4/4] power: supply: qcom_battmgr: Allow charger changes to wake up the system
Date: Thu, 22 Oct 2026 20:32:24 +0300
Message-ID: <20261022173225.58-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261022164151.592-1-tvlad744@gmail.com>
References: <20261022164151.592-1-tvlad744@gmail.com>
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

The battery manager notifies about changes of the battery state, many
of which arrive while the system is asleep, and about changes of the
USB and wireless charger properties, a charger being plugged in or out
for one. Only the latter can be worth a wakeup, to show the new
charging state for example.

Make the device wakeup capable, and set a wakeup filter that lets
pmic_glink report only the charger notifications as wakeup events.
Leave wakeup disabled, so that nothing changes by default: whether a
charger change should wake up the system is up to user space, through
power/wakeup.

Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
I used an AI assistant (Claude) for the analysis and to draft this
patch and its description; I reviewed the result. The testing is
described in the cover letter.

 drivers/power/supply/qcom_battmgr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 636d6f6acecc..7a783a3a320d 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeup.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
@@ -1596,6 +1597,20 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 	complete(&battmgr->ack);
 }
 
+static bool qcom_battmgr_is_charger_notification(const void *data, size_t len, void *priv)
+{
+	const struct qcom_battmgr_message *msg = data;
+	unsigned int notification;
+
+	if (le32_to_cpu(msg->hdr.opcode) != BATTMGR_NOTIFICATION ||
+	    len != sizeof(msg->hdr) + sizeof(msg->notification))
+		return false;
+
+	notification = le32_to_cpu(msg->notification) & 0xff;
+
+	return notification == NOTIF_USB_PROPERTY || notification == NOTIF_WLS_PROPERTY;
+}
+
 static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 {
 	const struct pmic_glink_hdr *hdr = data;
@@ -1750,6 +1765,10 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	if (IS_ERR(battmgr->client))
 		return PTR_ERR(battmgr->client);
 
+	device_set_wakeup_capable(dev, true);
+	pmic_glink_client_set_wakeup_filter(battmgr->client,
+					    qcom_battmgr_is_charger_notification);
+
 	pmic_glink_client_register(battmgr->client);
 
 	return 0;
-- 
2.43.0

