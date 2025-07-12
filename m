Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8C1632DF
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348268; cv=none; b=b7iNkAGeHeZENaulvD+EhLPVr1urwqatmnVY4RH06qndhD8Rwa1Ol1joi+X+ffDYlD1bOTa/qdgs5E+qS9V9ydnQVnMqGwJXqymGUbZgODtv3yEznbp9UBsCzfx1oQkCe93AF9ahAC1ag5UJaHBd8Sii+BJv298Q08YZpGxP2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348268; c=relaxed/simple;
	bh=cntT9ISZmkAAxydJCxv5lMAj5WC+QRHxphv2VyXoKvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQo/WqJE1IDKvfcICnS+lZhq+cFgr2H0N5QAsm+14WbCThu5UcHkQ6/ib1/nhvHwMcYRrLjPTE6/22ytJbovsWB4xzga4Sd/loqWoaJ19wdNgbKjQc8Q4h8S2SWsjBxNCS7ngoDxC1POfNfsfa0gkTmAis1sXXfaHewukLnp5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvaRG/CW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvaRG/CW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23c8f179e1bso33802175ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348266; x=1752953066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh5FOJf9OWl3XdK59dRK5fMCGNEiWM3OtQjrdDKb2qI=;
        b=ZvaRG/CWjik+GlyFvCfcvLlxcyJmYOdUdtRwSSjY63grFDOUByjTpLZ/fQCd/IyT1i
         qaOYLE9kB9rneRjp4FdwYSVS2/hFeFZmVNP5sEIphR/7OrtqfYu54quWNcxgyZFFcQL+
         d4VCDNoZewAnRdFI7zglCRNPXDF4oGzMslf7ZrMnhbL8mvFzqUkEYVgwO685Cfxn9Giy
         cvPmHlCSKN2QuhO8ImmgONNQKcWHL/y3fYykN3iEKyBbResOdHafsEvlqlXPkUWOm1Vz
         m8eUEnZZmUaWaDLsuHvArmRbUWUwJwrZVf81ka0q1TdVtoSa5R1S8gwWinhgswK0ceuY
         +TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348266; x=1752953066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh5FOJf9OWl3XdK59dRK5fMCGNEiWM3OtQjrdDKb2qI=;
        b=gEJB/pF345Rw8rZEn66F+Y6DO/uMvxCbGMMKvdMRx/oLPSI9s0l8xYsziqIwudUA84
         gJ5oUrzkKj7mMkfgUv9ycDIjEsQkVk3W2dNChXnQi9P0FVzdWg7Mh3CbWBpO6OsIymN3
         s1G9IOvKVS6unkCZmIzhJyhrfj5m+KRGY5INSruui6wBRnQ/gXbYDUPUK1i2LT7HM58n
         0GuCBzHdmwmPTAsvFr7y7s1doLutmTrU58idvNFiTyiFvuE6ayP4fPR3nJ6vjpxEJ1PC
         siBN4OY4Z03PE6kP/g+A3WD9LQTnwzmRUtAXPw/jRuhBviSxuDanr+o483V/Jnvsx/Lr
         gHHQ==
X-Gm-Message-State: AOJu0YzqQKL2sapCdGYnAU1/P4B7hXHy+W4eMfN2h+k3xF16dulnAJRc
	dOy6tbNdvUrnU8kovTuU9nKAaDe+nS6rr1E0LFqeDyPlzvmlTI7iayEE7fb+mZpu
X-Gm-Gg: ASbGncsfOPR84cqP6GA3b7ebHXNywoMPfnvOOLiL/0jqaLzycXgJRvmoZaqIDbEWa1s
	1zyrjDqLn1zl+wQ3jyV3b256PyiztrHKRxmDKQKD3jJxBHYaeOUWR8dy2b/NRRkEpAj2etgC74M
	4MUb7hS3Kd9oj2jXH+zL8sqipEbzxvBE6BkXBtktmUwlkQ1CmdHYEnpyiD//khOhsAqZAGPLUl5
	EnWrWJ1ojhulaRu4xkxRtEUugTSprpL7hXJ6vcv8mlVaUVngwgZ6T5r54isMO7LjxbG7pt3R5RK
	+g0iHlVuCximNqpNSeONmeEiqseG2Dn9Uo6HhL2+y0qIcnO1tLz2LRwB9Le5GV3CVBCkyGdisJE
	HEkxy13LMtV3kGhV5JglU05q31nrAXGikGUGahbrZ4uYF
X-Google-Smtp-Source: AGHT+IE//wQKYEDpRw4F+i+P0zPQQOXczlZJMtPS9iN+qnqX5i5zLBYZV3hBysdRSx4SqNHJW5gUJg==
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr131735325ad.43.1752348266469;
        Sat, 12 Jul 2025 12:24:26 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:26 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 15/17] kconfig: debug: add SafeFetch to debug kconfig
Date: Sat, 12 Jul 2025 19:22:00 +0000
Message-Id: <20250712192202.707192-16-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..d4b4214164a5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1040,6 +1040,7 @@ config MEM_ALLOC_PROFILING_DEBUG
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
+source "lib/Kconfig.safefetch"
 
 endmenu # "Memory Debugging"
 
-- 
2.25.1

