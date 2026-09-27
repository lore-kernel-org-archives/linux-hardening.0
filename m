Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997C3B776A
	for <linux-hardening@vger.kernel.org>; Sun, 27 Sep 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790488808; cv=none; b=IyMknvF6EK10Ep4TEKsYNyUIG+9ezOw5UC4vbBtmdRuzgqt6jaLV1ABzWhcGVsXf/s7VVim68eiIi5RHchcNMUj/ZgBvROz7w6cwitSzmKuiVqRHbztmY9w7GT4ZWQL9wU8pf4nYOMZfl24p5Qj1ByoPt2ZJZbeKQfmlKnQX+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790488808; c=relaxed/simple;
	bh=uav7FpdcMvoPqAG2gm25FMa/ksIC4Z/tBnVXRFPwCpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agSVROKYK36W65w9SAm1+oWMHJ3+ZF3xg2tGsJ4W9lSdHKO3h0IeTJwPNW8QzUN3BlTioy7gG4oG1fNa8KnZ3vxC3rBetGBssTC2Vijj3eu1l9F0e2JFIJDqwT+VmgGrk1ib/TjtJoMHXGLgD2lzsXOppJeMplODQiZPnMT7944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyZ45tRV; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyZ45tRV"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d06so1409530c88.1
        for <linux-hardening@vger.kernel.org>; Sat, 26 Sep 2026 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790488806; x=1791093606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gr7sKNDFLbCxJHInGWFYwlfKrCf9Hw79pJZTHn3AM4g=;
        b=OyZ45tRVDBcdD7hgU3xinj2wrLWKbz7i/swgT0vz6VdxyCujChQndhhgV1r+PnEYKd
         7wEIhh5BH6jzoLP2iK/Dt76Y4jJTIvPW0nGkOKjy/sAYXw1bS9RVj0YrMzzWc1OkMhQj
         UreO76kNpW4I6AdBDSE+c+P1NMUEhtUt5sERJTk+z/kRMwxUQqWCK3ogqg9BvIGRQLTF
         0F8ExhD2XhpxXnrA6BCFJhWGZq3dEOqSDeAs1X4YxZiEeJDdYwhUA2a6dugVmTnGHXA4
         ysEDGIMCSOwjUCG4qyGiURdQybfm7KxjOKZLpUyT7i/aBEwFoB4kg62ofTeeD0AMQcjA
         W1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790488806; x=1791093606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gr7sKNDFLbCxJHInGWFYwlfKrCf9Hw79pJZTHn3AM4g=;
        b=pjFO9zDaJnLslE1yRR9/AcA9yg3cwpBu4n94TUzwCRzTlUXW8C6kP2RPcN+iKqjEjG
         QKEtPATsZad/tx9xPRzddSOgocXnXUZwFFsRwUuFO6Lcd7JbcK5DRm3ejpA0z2tu/MRy
         GiYdEhAolTNgLOTPwULZrfFsAVvUMI7bpWBDEohQNM8TMCFdHiyCu4WRU9FXONIKveed
         sLnPqe3fVGyzJ2CwIZL/01Hfhuhf/TxWCo5pz10PrToCgEaNHYWthF67JZpi6yDVQrdm
         gBMTNnhTv8Dg9ueg+YRSdPOgIpQao6GLQneBQ71qpDM2MJ8Sw9zEDbUe0Wlr7FMMuzFX
         2EOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/nYTegRuCaqZu1pZf4HqLvrVvflBgjQ+Z44+2KYod/KJMvlhYFZGtIH6/ERSsMyWLs5pYUHRCurDbl6pRmBI=@vger.kernel.org
X-Gm-Message-State: AFuF++lvjJIYIUe6Ptdevl7gwP/spRscufiZETEIoJKLU1yC9kn7jvTq
	mIbALX2/9k1EzTxo2LcFKSlT0tYTozkauUJQJi9lb8HV91ES0uFNbrYb
X-Gm-Gg: AYBFou2KKJI35wgEE8uLPeUM5SJB2PntDSUAJf8ssbChFBS1wMMYUFo1ZMJHJ5+UjTK
	xY84bl4U5Nxhp7XsEWsvNNKWGfwxo6cCG+pI8zXzBhZLfCuvv0NihM7D2z5HaD3A5VPCUENgnvW
	0KSNjNUIjO98BLqNXA+1YhWrYkdMmCyZWfK/HKNWCRrw5PUb9LEiYi5XFeS42j73wfWrOj94ETh
	IvZHRvzbvgyvlJ/Bc9lFQHIoN0hJwR+iBLaCDKp9J/wzp7N7yNSARu7sAeqiqdlUotj8rlYm/vQ
	+wxGRr3fPXrSXCxPr86YZTahNyXsb2BQ45R6tSbJcu2E+h2+QaWviVXLzkcNRDZCZtyXzM3dLRN
	9KC4qtqe3VuvF5unEPxRtgprcsfhFrhpREfLPgm0WajQEfPdJPmiNsTKI/qw7wtaVrCsDlWSJjM
	2q3TOsSDgbrv1VLCIFYKucWdOQfHGI6Zf3c4GcTk7n//AqOL/5pgKzJwMf114kaP4v+DyyG5POM
	U/Z6mVOpp39kcn8oMIo5pNWoOp2
X-Received: by 2002:a05:7022:43a9:b0:143:4710:a869 with SMTP id a92af1059eb24-146cdfbecc6mr8275381c88.2.1790488805361;
        Sat, 26 Sep 2026 23:00:05 -0700 (PDT)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:be8c:736b:d7b9:ea97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm17500013eec.28.2026.09.26.23.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:00:04 -0700 (PDT)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	morbo@google.com,
	kees@kernel.org,
	justinstitt@google.com,
	codemender-patching+linux@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] comedi: comedi_bond: Refactor strlcat() to seq_buf in do_dev_config()
Date: Sat, 26 Sep 2026 23:00:00 -0700
Message-ID: <20260927060000.518354-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bill Wendling <morbo@google.com>

do_dev_config() builds a space-separated list of bonded devices in
devpriv->name by formatting each "minor:subdev " pair into a temporary
stack buffer with snprintf() and appending it with strlcat() in a loop.

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf and seq_buf_printf() to format each entry directly into
devpriv->name. This avoids repeated rescanning of devpriv->name and
eliminates the temporary buffer.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/comedi/drivers/comedi_bond.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
index 8e10ecab4f0d..a10cfbd04c72 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -39,6 +39,7 @@
 
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 #include <linux/comedi.h>
 #include <linux/comedi/comedilib.h>
@@ -170,10 +171,11 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 {
 	struct comedi_bond_private *devpriv = dev->private;
 	DECLARE_BITMAP(devs_opened, COMEDI_NUM_BOARD_MINORS);
+	struct seq_buf s;
 	int i;
 
 	memset(&devs_opened, 0, sizeof(devs_opened));
-	devpriv->name[0] = 0;
+	seq_buf_init(&s, devpriv->name, sizeof(devpriv->name));
 	/*
 	 * Loop through all comedi devices specified on the command-line,
 	 * building our device list.
@@ -250,15 +252,9 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 			}
 			devpriv->devs = devs;
 			devpriv->devs[devpriv->ndevs++] = bdev;
-			{
-				/* Append dev:subdev to devpriv->name */
-				char buf[20];
-
-				snprintf(buf, sizeof(buf), "%u:%u ",
-					 bdev->minor, bdev->subdev);
-				strlcat(devpriv->name, buf,
-					sizeof(devpriv->name));
-			}
+
+			/* Append dev:subdev to devpriv->name */
+			seq_buf_printf(&s, "%u:%u ", bdev->minor, bdev->subdev);
 		}
 	}
 
@@ -267,6 +263,8 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 		return -EINVAL;
 	}
 
+	seq_buf_str(&s);
+
 	return 0;
 }
 
-- 
2.43.0

