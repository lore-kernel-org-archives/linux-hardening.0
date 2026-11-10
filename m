Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303104;
	b=j8jKRnB1qYlHEmwbt2OjzK+G0a5w6HFp3vKJGY0G3BYZwoHbRvaI0adPSUFbCRST02Qw
	 UynkENJ2TxbiDy8Vi8hQ01NymwbQWd7L8AIW0z3d/keXJUUdmsOewaSGKcJkBCNXc+zya
	 sIMUjIOMIJR+xhFhtgQczzHuDnn2nG2zrIocrWrmcwYaA1ojysMF1qLe7xtB11wuWkMWE
	 O5pVn64mGMBWa6i+iPSNco9VaBhxhEuzwZHkjYscWl6ylKLtJNhmS1dwjRW3KO/dRMHtx
	 7Gv366C0AS28TR3Bk1Ip9RzQgCJaaT+cRSVqG1pdZCpaVIyuuQDuGo4aesyPWVB7WCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=70d5HP/NDskHf8kArC44fYJ/2R1MLgLSjk60RYC7GPQ=;
	b=sBLytYaeugmbkKhgOEbHb5J7/oDvQQlcksjTwAryxdDL/1Iie0gb5Bbr2tehmx9i+t8v
	 oDVDuXe6Zruhqmcxu1xiK5WSKtFaVnLvhEf6YF5CtV/WexcgH068++x6HmWXScTaM+Lzv
	 TRwc0HOIt0TQ29yyLtwNTM38BvpbjE86bvFvDNTu2lH1aQgF/lYYLncN+2nhqhiwznPW4
	 P30QlfEZVdhNWiuQDhvetscFJzJt5TsEqJ/X5NG6PYgEDjOtw5sChDv4htW0twhO2ttDZ
	 Nd2kK/4n7NZHQF9JlPm63vm3pVM1+8wZVfteoJMGMGIOvndgf+EOJs70v/4lrUprP0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6VpWtDm;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A173606CF8A
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 09:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A173606CF8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6VpWtDm
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2980777eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 01:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794303103; x=1794907903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=70d5HP/NDskHf8kArC44fYJ/2R1MLgLSjk60RYC7GPQ=;
        b=m6VpWtDmn0Dldk5emvFKnESyohulG8uw0ZwPMGdM/9S9v9cGrlFeN9gVlckf0Mv0qd
         3fEteFvJtcrNghTloBDMtkBU/VUpnBYwWJGrWgbJ0TaRfH1Gh067jvJyvnab4B+wgVrs
         59hh1V5259n5V2cFrmtphIhIRlYE7Ju3zRc+8t9Sy3bmJzvV6sEoFD3SH9SROk5LFspc
         qIRJ4gTKCCniqI0K3QDpfIEI87CwGTcMfHt8fp+LwWdqE+Ip5GlYa+1E6hy1pFyOGnfE
         VUwYg7oOCMTKdy4QI6YD6tLww1NgQkM2GoW7dN5f8M0DqdEBrD9z/jv8huYgv9A/vJbT
         Nm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794303103; x=1794907903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70d5HP/NDskHf8kArC44fYJ/2R1MLgLSjk60RYC7GPQ=;
        b=riijA0LK3KXvZVAjxDNddl4JBHL5zvaX8ZQrh0HydHJNfZmhl2LYQqQ/iyyakld7LQ
         V/oHoHbhMer9L0ED+D9DSlyK5y+0tOUbzFZC0jDh/mFmnKqc/vnauMpSBDLfkMKQ/8Or
         frXTpmthr+uEbMw64awmveF2wsSzirQ95lm4YeHNz5tnaQL+jZQrOqYZHrv/d5lk7SZU
         TiiKm2VLXZYkMevOozwn1NW+0v7C0XXXDKvpbF3FUE8+QI5ssip0jKW1GcffI/M4eGfQ
         weASU/SyZo2Bzh3WO/DHRxh1UloxHSyHC9HwlClKWL/hrJrXDTloYLRBNpjxqWU2Hzf/
         Mo5Q==
X-Forwarded-Encrypted: i=1; AL+hErG1hLOT0aS6KoXE8KpRO2CENU6UoTbNKtlHJhF2BEsOU8GBfCQnOXlBDH9MAniut1fccZOHMCxCDysW2iM4mDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RiEx44r+nwNmYoSXjKj484w2oPXp6NGzYdo1Z0y3KG8Sznpbh
	pgKhow/X1H3JdsSU/V8vgpPGiTv7GzbIzmpWBcE3pTMS3QDaiFbeNgzP
X-Gm-Gg: AYBFou1lIbzr+6gf4zhpL19KKxAim0xcBr2Sa2Yf/F26whddNyr0QPMbKO5kjk6+v/s
	6HADRr0+8RdOuZ6SXJkl4o9y0X2fRhAhzh88Dpm1g2sKaCiyHb3T53EdBDjAummj2i+LvRIyeGL
	A5bln9oSulXiZgy+9+xCFjCrJQPIgCqozyJQ1/Qpwb4PCdLutcqIZUq6XOH+/TRbRx9vwZMK+Ty
	HoSH6//rSqnk+Vg1KiPKNhdHqlkHTGlMPHMVprUmHjFohdZiBkfL5Mim6NkyBlQTHFpGJyKJALz
	9OJbI8vvI2nnfUZVEKpaFTbyYJcXlhdhNLvKqu2sI8/ph67cVj+jO7gfORDsdDIcJAiD+F+3wWd
	ahcaPk8m+6zPb5dDEgn0Boq0z7+vRdYswEcEM9NGltGROTQ4HCIQnnE2DZTMHsz0qJgsxbKVUoi
	jOcad6AQ9w7YP/M79naghOZbWnD1c+gTRFFvE8qN6ckCzHrrNnfYUGVrg83qfxYVdmBXQya66vu
	bguWj94iM7MmodxfgcSamBQTAtHsULLra9l3LalBLu60sR10VpV2Mxa0Afey47Kh087Y8q+jJdc
	5XLec1ZznmSIdTpfD+BF+2a4SDPpAzKzCUwCbWlR/KOAF7S1XQBpnvw7Iyo=
X-Received: by 2002:a05:7300:da01:b0:351:29c8:643 with SMTP id 5a478bee46e88-3751f46823emr2583654eec.18.1794303103003;
        Tue, 10 Nov 2026 01:31:43 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:140f:bba5:1d89:57e3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm4840148eec.4.2026.11.10.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:31:42 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: mkp@kernel.org
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	morbo@google.com,
	justinstitt@google.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] scsi: target: iscsi: Replace strlcat() with snprintf()
Date: Tue, 10 Nov 2026 01:31:37 -0800
Message-ID: <20261110093137.37744-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In preparation for removing the deprecated strlcat() API[1], replace
the strlcat() call with snprintf() to construct the AuthMethod value
directly from param->value.

Since buf1 contains unmodified copy of param->value, formatting
original value and suffix together preserves the NUL-terminated
output, including partial or omitted ",None" suffixes when the
256-byte buffer is too small.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/target/iscsi/iscsi_target_tpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 99772364c88e..aad82a37538f 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -624,7 +624,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group *tpg, u32 authentication)
 		none = strstr(buf1, NONE);
 		if (none)
 			goto out;
-		strlcat(buf1, "," NONE, sizeof(buf1));
+		snprintf(buf1, sizeof(buf1), "%s," NONE, param->value);
 		if (iscsi_update_param_value(param, buf1) < 0)
 			return -EINVAL;
 	}
-- 
2.43.0

