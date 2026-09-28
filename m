Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC01485CF7
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586044; cv=none; b=GReL60Q1wbXVssvCBYqxu0FLugJf0ZMrDqKV54CCNxwkPebKl3HaujlL3fT94nG+UySu+KFfr3/nb68j+NHwWHE9JXQci1WV4H51ARNkGBR47QZjClzpx0D7wsTKjSswMqb5ELRWLXx25sdQ9nHiGM4cOLKQGcTwrDX3jOeCLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586044; c=relaxed/simple;
	bh=LKlCoviJ12VgG5jnRcP5Hso1CrjmmA02TTiTGOaT5l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k94YWI5HEr8lA5rqstd6hZYh8A1wBS2sdUquNPCloMxpQAZdhHf1cgRZURmUG1L4g/cu7WfwNY/epkCgl7/dR500YWgdW5P7Vy9LrBOwuWcy/e8P6QQGzD3CLOf75VEv59qKdkq89xeMQ+xfnCllRxB3dJ7BCfgScPnM+iTlyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D07nw3re; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D07nw3re"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so3361824eec.3
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790586042; x=1791190842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4As3nxVg8g8B3dLip3XefSLbWFq/mZSzoIcZeIzSfg=;
        b=D07nw3reiH69EjzEim6t0FoUB0kuO8Ntc/ZYaWRhvyG1BEsYBZhtjGN1TzYjMZWxqt
         E6JfKJQ/8UwzkWRsxo5YsjleoHjO9v5ru6FXUKrI83WWKPc34MdKVaqX3BXraObYyK4t
         1qRvdKoRTvkIDHifXQBOoidhe9vBSktiMR3eItJyWcezkuObT03GK+lT/Wbn1z1dlww3
         7zVNImKzDVKL8kpFTK1o3kDTsGzg5U2yOJju+QOjvky7OXBHxAFII03PbV5UM94uXk0o
         +SzE/GJ6npDB26DOUnriQni6S15X6CjvtKf5lzkEgGBgWkVI+dsC02JYyKBZNTtam2CM
         RgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586042; x=1791190842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B4As3nxVg8g8B3dLip3XefSLbWFq/mZSzoIcZeIzSfg=;
        b=au0ACae+jQZX0cDibnuuJ3UFCbNIBqh6ZO6xaPcJ/HtQgLpRbpngcrXFP+VHai5Rqi
         O8n9VL/z9eSiLkNN3dlEmrhWGCTAutjbVY7IPBioFPjMRkrRR7ZZu/a9F7KIwd6FSa0C
         3iqVe6mHEz25BJnuoXts8myKL9BAH6o2QlaN+tx9RuhJtm0GYHsXoNk4O751avCToBsl
         zP72Ft7gZ9mRxow2JMrXqyMgJhH6QT2f3iCqlcOrxcjtpg7PJvoX7H5m3lCdoCoeWe1z
         cVG0+Pck9Ba9HysKNYCEN49Bjz4wOl5aW3GlOWFbhJINkJ0hTFpoIHiNTkzEK2rpl+n6
         Q9/w==
X-Forwarded-Encrypted: i=1; AKwUvBwQB5VgrOBeyp22WXDEQTYw6xRi+Auh+HOlLddo+Fx+AWJ8v/ZD397/uSpsFBkUv2ovIMb5l/+n0zH9H7Unzdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIV+bk8USfatINXL8OYiNBQGuzvjimv2sDIJ5IcUbCcZnrfGCv
	Wofv0YtlF8GOl33cPWfami8D3W7mJVx9Y0w94L8Qy9DNMcYB7buL+NIT
X-Gm-Gg: AYBFou0OtJZmO9kb+mFPQzdTsArFWIlKYW+u/dmaqafxcAOJF/MiyLl/jpQNyiKFT0e
	jZFGSmSzxJ+2v70J1F+M4l1ZYciKwSXQfhPo3vWJLntTf5vAo3to4AogmaT7f/YK77wONonGsSa
	C1i8ZYDewblXc+zpyHnvwMNkUawAcP/rSwpPXnlHIfNg5LnZI86ZH/bnjAD+m1Buxe4GLgZ6WLK
	l7j2bKCP0+brT2RSIER1sLgLqbShwDgBYqWm2IV1k6z5vygHfZbaWM8DMvd2xbiQeznTY5gVeEG
	mfnhb72tl0wLs006XMuaafIBWZUg3c9pMuFtJKoekBZP0sRRLA/zBCEXdRp7w8s4aGvVAhgYnf7
	Vns42byTgtFWANtfDebDAgYjfTT5oWbKYPHEUmgQaVS6QfAFRO8/15atsDZAmfE78PHmh6wBks3
	Njop2cPPQwQHknVdtqhLLA7q87zhHAnWkUZc7+jBKhM3Hv8CGk2TMzWygPTVE/x/uxhaJdL8ijH
	o/wjfj+4JRXUAAwIYEsyNO83ZEX
X-Received: by 2002:a05:7300:8250:b0:342:94ae:98f8 with SMTP id 5a478bee46e88-34294ae9cd0mr9071212eec.33.1790586041380;
        Mon, 28 Sep 2026 02:00:41 -0700 (PDT)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:3430:2ac1:d99f:94d7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm43351473eec.9.2026.09.28.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:00:40 -0700 (PDT)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: anil.gurumurthy@qlogic.com,
	sudarsana.kalluru@qlogic.com,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	morbo@google.com,
	kees@kernel.org,
	justinstitt@google.com,
	codemender-patching+linux@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH v2 1/2] scsi: bfa: Use snprintf() in bfa_fcs_fabric_nsymb_init()
Date: Mon, 28 Sep 2026 02:00:29 -0700
Message-ID: <20260928090031.712418-2-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928090031.712418-1-nikitash.mariiaw@gmail.com>
References: <20260928090031.712418-1-nikitash.mariiaw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bill Wendling <morbo@google.com>

bfa_fcs_fabric_nsymb_init() constructs the node symbolic name using
strscpy() followed by five strlcat() calls and explicit NUL-termination.

In preparation for removing the deprecated strlcat() API[1], replace the
chained string copies with a single snprintf() call.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/scsi/bfa/bfa_fcs.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
index 9b57312f43f5..7a4e0e8c7182 100644
--- a/drivers/scsi/bfa/bfa_fcs.c
+++ b/drivers/scsi/bfa/bfa_fcs.c
@@ -821,30 +821,13 @@ bfa_fcs_fabric_nsymb_init(struct bfa_fcs_fabric_s *fabric)
 
 	bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
 
-	/* Model name/number */
-	strscpy(port_cfg->node_sym_name.symname, model,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->node_sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-	/* Driver Version */
-	strlcat(port_cfg->node_sym_name.symname, (char *)driver_info->version,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->node_sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-	/* Host machine name */
-	strlcat(port_cfg->node_sym_name.symname,
-		driver_info->host_machine_name,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->node_sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-	/* null terminate */
-	port_cfg->node_sym_name.symname[BFA_SYMNAME_MAXLEN - 1] = 0;
+	/* Model name/number, Driver Version, Host machine name */
+	snprintf(port_cfg->node_sym_name.symname, BFA_SYMNAME_MAXLEN,
+		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR
+		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR
+		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+		 model, (char *)driver_info->version,
+		 driver_info->host_machine_name);
 }
 
 /*
-- 
2.43.0

