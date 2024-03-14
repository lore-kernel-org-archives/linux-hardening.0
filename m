Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5676C6D
	for <linux-hardening@vger.kernel.org>; Thu, 14 Mar 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455383; cv=none; b=HDqeTBVOEW/x4so81HMzPNABsyqZH75qtbQE6gRPtOCs/OW1I+siyaTyb89OVboiAXKfP5uVqPhrMPI4HzXCc8D9G7ilz2NbMqjPErj3h03WVPYZbLzHXXVK/evcWVckyvYrDTcSt5x0R0oh20wTG6A4X+IT7mPca83sOr+NBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455383; c=relaxed/simple;
	bh=0y7oXfa2G7iiYQcQPwa5O+JgaheSC4GaExlqqlUSBEg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CM6P3wbA/SUo5x8x7GhNxjPSamuGnFfxSXEcoOvbZ4meU/TkuI/f4kyBMCuFcW37+Pa1l3S1QyO9GN/SIvs+wsohvLwwMLPLlpNv8MXI/nbbGycYxCNKQinyySIebM89eTKMbVrwm2iCsY4HPVUywa4G35zOzC17cgUsBaoJH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jh4WruTJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jh4WruTJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so2089803276.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Mar 2024 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710455380; x=1711060180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bw7VM9ED7eVgs2yIUEIDaex+hm93Iedl3Ou3zhuMvJ0=;
        b=jh4WruTJe/uxBEeLsVinELNd+Ty7vyVKRcPDN4JNhwwVfz+ylcOvDKWAvK0owwcTFE
         lyuTuHx6m/qx6kj22mgQPOLyI6ZwGfzF8kWtmmH9ZfBB1CpWKcdFFFCfXlCbqYIh+ydC
         7aYCkg6nAzU5TmhTzEfH+fGtt+aX7XR8vlv3v9FyRuXJDtoi7k86wPwNkOmZwMTMwlqd
         Uj9fHYbxlH4BtTgTOwHK+1ilQlcSgBcG2pwDxXriuwRNweES2FqpC/tk+KxQ8ZjJdKMm
         w5M8fZaDpMchuBYiQ0x58W6oh/ushO4C2oPpMh6q/L2hpTZrUwSklQaH3bZ8Bpy4Kkdp
         vLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455380; x=1711060180;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bw7VM9ED7eVgs2yIUEIDaex+hm93Iedl3Ou3zhuMvJ0=;
        b=s2oPRq95AaMHXiEN0FTT0h+iaKxsrWlpscfaQ2gG/LAg8Oea4P26+KPcAWYk8Sej3o
         h/NLH70BTwoWSKVaqY2/oYQ3rfUhZ62gYMdFS5S0WGw9TJHvKij9OLO2KFRtXaTo9u0q
         YGBpMUOrjMmBE8ei1pIcvf3qRotFXCWyqgQ5a0MW+2kaeHcWhk8m/eb2yXQtCEhiym+Z
         XcErF0DpUOfH4WJkrvIcIVILkrIYYB/x/9iIeUHJepSbBBC+5zQmo8MIkpkyR63Mf33b
         I163lWGdzJqP2i6e+lx9hTVnJgbJ6crNzHONLV/B3llRv8HSA/dEc8wWCxkRvAdzF3Bm
         wnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFER2m+CzTIRCnsAx9XNOMUFt1hrwNqZi0Yw9RmpQxAtw2xncmL8rbRGCPu4NQVxc77Llf9YGmKiIzhUHuRU2FSfkXbjDoZw6m+kbbkpR
X-Gm-Message-State: AOJu0YyHAD0cl/6wdBwSd1fQG9c+AaAtwl0NcxC7PxcMWVD1p7Dym9uL
	Xj9ELpZYB/K2DpurLRzVqFGqwkbQVCGUaJYwnhREX6w97oRlqgNtnwpnuo/+AT+PcUH0FRANdD0
	BfxdZuEt4xivG/AQpsYptuA==
X-Google-Smtp-Source: AGHT+IFMyiMRVKv43irpw3uNDU30O1gPYqgcBLyY5YZq+gtOE4zxefR0vaZAt5AtUEE0rcq9mTQo1J4kYtP8mw3sAA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:72e:b0:dc6:e8a7:fdba with
 SMTP id l14-20020a056902072e00b00dc6e8a7fdbamr895492ybt.4.1710455380548; Thu,
 14 Mar 2024 15:29:40 -0700 (PDT)
Date: Thu, 14 Mar 2024 22:29:37 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFB682UC/x3NMQ6DMAxA0asgz7UESQbUq1QdEse0HkioXSEQ4
 u5EjG/5/wBjFTZ4dgcor2JSS8Pw6IC+sXwYJTeD613o/RDQ/lpo2TGrrKyGVgl/VGekOWNOSOj GMPmYYkxphNZZlCfZ7sfrfZ4XL31WkXMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710455379; l=2127;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=0y7oXfa2G7iiYQcQPwa5O+JgaheSC4GaExlqqlUSBEg=; b=ZQp+RyhuScBoaTsu2jjwQLQsgukHp/8xtup+g9tOpnSLLlPtyydTcv55z32T4I3acEXFRlQvs
 1+0UFseQiZ7Cp3BuEy9U8rQC0rlBKfIM4BQvhY1+A20BFSYYI6A1FYx
X-Mailer: b4 0.12.3
Message-ID: <20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com>
Subject: [PATCH] soc: qcom: cmd-db: replace deprecated strncpy with memcpy
From: Justin Stitt <justinstitt@google.com>
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

@query is already marked as __nonstring and doesn't need to be
NUL-terminated. Due to this, we don't need to use a string API here
(especially a deprecated one). Let's have our stack allocation also
zero-initialize so that we can just perform a standard memcpy. Since the
code now speaks for itself we can drop the comment. A memcpy on a
__nonstring buffer explains everything that this comment talks about.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/soc/qcom/cmd-db.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed..512556366a3e 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -141,18 +141,13 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	const struct rsc_hdr *rsc_hdr;
 	const struct entry_header *ent;
 	int ret, i, j;
-	u8 query[sizeof(ent->id)] __nonstring;
+	u8 query[sizeof(ent->id)] __nonstring = { 0 };
 
 	ret = cmd_db_ready();
 	if (ret)
 		return ret;
 
-	/*
-	 * Pad out query string to same length as in DB. NOTE: the output
-	 * query string is not necessarily '\0' terminated if it bumps up
-	 * against the max size. That's OK and expected.
-	 */
-	strncpy(query, id, sizeof(query));
+	memcpy(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];

---
base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
change-id: 20240314-strncpy-drivers-soc-qcom-cmd-db-c-284f3abaabb8

Best regards,
--
Justin Stitt <justinstitt@google.com>

