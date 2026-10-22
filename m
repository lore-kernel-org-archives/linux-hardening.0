Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687348;
	b=xfR/P0G4R5F5C+z9ekGky9un2shz0EGtAW/O4YBMw87Y87nYXmwebHeXrLQGnnfu4szs
	 9zo1GBRs1CRt72aL9pc5eatk+/E17INj0ILPpjLqCG56VbmlG76FSdfQ346qb+cKdiJxi
	 2Fc+6WCIcM9JEfSwsqBiZGk/+5ilDd1TSaM7Kt66SANkTDCDi1W1nQ8n4ytFa/NC9glO9
	 VFMrLhkBzXN9/sJp8zV0px3WKqmm0MX4S9KbLF5HlaWnk8okIP4OP/oWZgwJWn2Ygg0HG
	 oT4nJ44rsGpNQ4ErNFS9uwqE15NoKbqBMVlX+BDarIlvF+NxrzJyYAiwuVR99fdDL1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zblh9RJVoqtDhwxOvvPdwA42GF2EgXCszh/ysjfgfTI=;
	b=CkK61Yj2BjGJFIagyryxmv4Alufhk9FROD7e1w8nGLjFW/7+REtalG1kuePpGqdCxVwH
	 W9j74mm7DW+bTso9nEdegi/PkYB9SS/B3VUGmdR1YCAO5V10Qm5avSnTtu0GklUFOFbE+
	 lPmjnnfUmRT/YBo8sGlH09ZM5q2mmf8gLWMT+P917q1sX1/FwtFCzNc+x/xLipgSsACSL
	 /c6fWxUoP3DHnU5ImzlI6mFl/SX8czyfOzGqTFJmSlvSpHHFsLwV5YorEwz9wSCuBw7Sx
	 Pqo3ZQw4IXq/VO6XqmgmyYa/oG0UViu289HJrB8d4HknZ9Z8DoANqCWG5zBXojqxjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVUIURyu;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04669606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 16:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04669606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVUIURyu
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1466791f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687346; x=1793292146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zblh9RJVoqtDhwxOvvPdwA42GF2EgXCszh/ysjfgfTI=;
        b=HVUIURyu90T8GjQn2XXazP7dCqrkiXuYpUxCekjY7600wY09bAmNd4mE46R5Ssogk2
         CFN6+ZBuNhKlfANZH2F9nzhjn71dnyQbdos+w+SU0yfZwElm7P9o1S4gULAkrdjPI7UL
         XTodH5b6q94BoS+3Y98uhDdz7YVJrYmsHiJ7kyb3HN4vfUH8UeiU7tByzCLzy+8ADjRp
         3NZcDrkHTPmVWg7034QG1bqxqVpommIF7hvUmnY9VCBWIPRHvdgdY/cpWD7fMImCMFud
         MnRjBah85GPQEsKA2fKzvsJ9rDigodkvJHh/PImruCVzjkKI9SmsGI1C2TuEdOd/q7oS
         x9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687346; x=1793292146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zblh9RJVoqtDhwxOvvPdwA42GF2EgXCszh/ysjfgfTI=;
        b=JY079izmpEelsdPae7OIeEHlUFX0mZ5iQhVA+tGe/xXHe7MQ6VfiXT/6agJIDcpjyr
         +yqyV64hGHdjxakFO6MejxH0FJPnhfSKi7F4p1bIH2kHfkownSD4Ii8OYz5h8hPmPeJu
         leWv8EiQA/XvgaiOvknXyK7zHOxClfntC7XlUXIC7u6aQiOuMk7bTudqIKvuru71ruu5
         kelpBfVa91bWtXACUMWJKH3edpbL4fSy2icYr9LCTTUS7BIswKUA/sa5qaKvAZIOnD0E
         MqfXSM1G6+WA/3s7DIOeX7/61nmjk34toj2nbbmhNnNc7fKGNuasATvT1ICrMd8x4vlf
         OScA==
X-Forwarded-Encrypted: i=1; AKwUvBymVsEVj0dAL10xSPg+OT6lN+w3Hom03TNuHs0mEOToMYqen++xLPAr782suSh2n/WdMor1ZnTNlcw6Wjabob4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5cDK8jmBfDE/FT/T/ZleeppH1qBhjQVT8KwmDmqqBcOMegFhr
	r/+QlCCXqkGMhSEf1TTcG1ZZAvhLoyMSKJuohesbd4+cXLdE5oAJK01v
X-Gm-Gg: AYBFou3Kf5NDp18eD0GjI6xPA8vC+okghn/7etnzztoCqXEpJx16kBGuCUezq6Mahcs
	hiUBNs2ekGEGPK9ICYuhl4OzciSZvr8llineUXvYILRxt1TQy6HxxDlflJGoDMmFYqQDxEN9bEc
	xJMv2fv0pgB+v6a9pRX0qJjEMoeH+VdyxTxHug1vUMH/Yy7KfHd8kRETGz1PpG2Z+Io6jK03LA6
	e6RCkHdxOTK3JOYIoovwbW3uKeM9wYSHfwcu64/KXu2X3RTtgDYD10CNKkrmYBJ8Aw/s89/ynC+
	5iyARiuOplwPO/h+3X93z9mM6BwQQ/LDLZVuXdNNvOZu4jLchVJPVwRtn6M1L3m7CIwqfYwmNad
	1t7bhCd3B/YAy9f60DmCHLef8LZd80Wnye/Fxskfs5cvWz9+d38kvDm+SM3Gxd8Wa1MwGmYZ+i8
	o4U4bDoATYFd2uNxhFqyyvceQbxJn8Ri1gDwz00d4rP6Yh8cGkj1wvuPfIRKBG48isImnBv1DId
	hgLsiI3wxxQCczETKryMGPetPfaGCutiXKhGs7fEexVGL78PZ8tZV8BpB6ZLdtTC9EqMcrs3qCI
	JNCigacTb4GDSLQ/0vKphW7TF10=
X-Received: by 2002:adf:fc4a:0:b0:48d:fbee:3dec with SMTP id ffacd0b85a97d-48e264c8742mr9406786f8f.29.1792687346264;
        Thu, 22 Oct 2026 09:42:26 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584c3b0sm15040175f8f.57.2026.10.22.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:42:26 -0700 (PDT)
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
Subject: [RFC PATCH 3/4] usb: typec: ucsi: glink: Wake up the system on connector changes
Date: Thu, 22 Oct 2026 19:41:50 +0300
Message-ID: <20261022164151.592-4-tvlad744@gmail.com>
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

The UCSI notifications from PMIC GLINK report connector changes, a USB
cable being plugged in or out for one, and the completion of UCSI
commands. Enable wakeup on the device, so that pmic_glink reports them
as wakeup events: a cable change brings the system out of
suspend-to-idle and aborts a suspend in progress.

The completion of a command arrives only while the command is in
flight, so it can wake up the system only when a suspend has started
in the middle of one.

The same was proposed in [1], with the wakeup event reported from the
callback. pmic_glink reports it now, also for the notifications that
it holds back over system sleep.

Link: https://lore.kernel.org/all/20260722-ucsi_glink_wakeup-v2-1-b43dee56df24@oss.qualcomm.com/ [1]
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
I used an AI assistant (Claude) for the analysis and to draft this
patch and its description; I reviewed the result. The testing is
described in the cover letter.

 drivers/usb/typec/ucsi/ucsi_glink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1db0c88d817e..b03320f5a6bb 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeup.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
 #include <linux/usb/typec_mux.h>
@@ -455,6 +456,11 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		ucsi->port_orientation[port] = desc;
 	}
 
+	/* pmic_glink reports the notifications as wakeup events */
+	ret = devm_device_init_wakeup(dev);
+	if (ret)
+		return ret;
+
 	ucsi->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_USBC,
 						    pmic_glink_ucsi_callback,
 						    pmic_glink_ucsi_pdr_notify,
-- 
2.43.0

