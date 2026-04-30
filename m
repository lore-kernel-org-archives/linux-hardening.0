Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DF40DFD7
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531266; cv=none; b=rB9MrTJ6KfS4DJcAQeoeoi77jpDxKZs9AbEabUGBrC3cBCPS4OV57JF1ZTzhKuSq6jdtqTJetEIA06MxIbz0/WX3aEs/QGbcBdvwbp3LYC1zSLxjSzOgF0KXzI4rOsc1rdZDBZ5FjHOp5LAAOUxBph+3+15mNrskdE+Vwy23ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531266; c=relaxed/simple;
	bh=lj0o4KC/6wYq51we6TcGFA7uHWAAMszCT5nqJhO/xHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJpkQBT6kME/vkXpMpcV/fDZgLeTCnQ6MXJdbddF4BYfmjkwfJuODUoFxNn+DWKbbG9UMN8WjVBzFRCIPIW59ldl2zKo34KOsPzDdvCPeA58YnTtmHdT2+y0EMMK5bkA5Mr+eWGKluAp4/VmNx8RhC7oixPfwD3yCK2kYg0dS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shdOhSjQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shdOhSjQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9705613ddso3580785ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777531264; x=1778136064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4phcO2WTBQ9p3BcYaJB7UNWV5euOcgZdUKLf+ZIGIi0=;
        b=shdOhSjQrLp/o5sii1miaDpaOR+6DtjznIfp+MGD/vIUFKQ/be6MHgxLgaaoCNwJLu
         F6YffoIgQHI3LVp/u5v8zfTIQPVqIQUzVrl+kg0kfOhK/qQ90YascQfu79j75sOP3jBY
         vcYkpen3QIg/GuD37qGrGickbPt463GP6XP0OGBOke5/8wZOIMHJhKBMnqmPuCMW0kjp
         eFCtA4WrvISJUCAIDOHxU/Cbfcps8vUvlduz6V03OmInJ+BFw7eE6g8HUh98O5STJVXZ
         GYNalxUOIR+Tz2lwhHMBQAL0E5oLAJ4EVnYjC/UC0ImTwWHNNHu1AUUBAmXqX0bBADUH
         qRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777531264; x=1778136064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4phcO2WTBQ9p3BcYaJB7UNWV5euOcgZdUKLf+ZIGIi0=;
        b=Vdr6hmPKSpweZVtWhtmDb1efUbPsWMLjSY+RNWl9BYplTlUpcz9M4XGV+JiUcJ1I6P
         HJtS7qLsZFpaLwg/zFqliAlo9MfOw6dc5mXOGnmyHR7wJnKCQKtAIlthcsyhCHkj9+O5
         HQjOSt0CRqdW4fyYmDDXUZEi+hgLVWpNklVJFSsFm9wCLKWHsZiBlBUYN3Wrniswh8qM
         gvNkvxkWELEL7VUvZG2VVpskFqT1DMFE6XiCK1nTL5k4qQTultXkdzeR02S6feRzMHUE
         zN+dIO6YWsdt+WY1ll1FN2eh7nBnCu6HAcW8LFTmIvqsh76hoUGvnvJ+YxFwsjxiHu9j
         HZRg==
X-Forwarded-Encrypted: i=1; AFNElJ9Wmm2RpqCGw0pDqK5xBfLTmMVYNcilWnMGYaTPPYkVj0gvpOUNNJE+7FDs+SS6pFHSJd/YLXCCqy1AK83fDn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sYEdJvBkeW9sWmBq9JgDqiUnj7bSmjWznnsC5ZDx0xY4B5VV
	3j9M/VlApFlKkYDQfO+J1Ajm2MYzErVwH2kRNF2dluzUt3oAYLxA5t1l
X-Gm-Gg: AeBDieuT0AhBzy397kEw6svvLrHZrK4C9UkwHdsRc9yP0KI6qj+eJaS1VaE18X1Trjd
	EWBnFm+Lw052mJB8oOSpL/Lx9syLMMQNdeD7Pq5A91cbUfK+NhW51Ak0IXuwcAazFm+a/10IpNZ
	TrRDX4PWeyk9zU8roHIiP46qCZFBeuYhUwBswdDqherAgsNRhrH0Z+Q/dAuBm/hQPShBtrqfwio
	Pe16CuMJ3Ox3E+KWVeiYn5xVbiV8uWfoTRtjLRnPwTvQdf8nCA4pxxEFPPEUaK7O9UEZV/o0KoJ
	3GTbSoXBljyNjyO4pyXYkrr04oDJNp+1fha2jgiKkH6b432NW7/bf1hpK/vVfpFA6sjqg4/6KRf
	WHFzfZ8o1Gx0qdTCXksrmD8BlELdVPjVntzSMWkGPDM/hAZ07cNFxjhGb6O3g2fPznKtfjIPA2x
	gv1x2IpiLt8Zi4YMdnfJVD8AecSuB8Vz+3OkXlzp2D
X-Received: by 2002:a17:902:b48f:b0:2b2:5203:acd3 with SMTP id d9443c01a7336-2b9a24b8916mr12027335ad.26.1777531264349;
        Wed, 29 Apr 2026 23:41:04 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6067403sm3835716a12.10.2026.04.29.23.41.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2026 23:41:03 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] Add str_alloc_free()/str_free_alloc helper and
Date: Thu, 30 Apr 2026 14:40:03 +0800
Message-ID: <cover.1777529232.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently finds 4 locations:
./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_alloc_free(valid)
./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_alloc_free(valid)
./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for str_alloc_free(alloc -> pages [ i ])
./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)

Jiazi Li (2):
  lib/string_choices: Add str_alloc_free() helper
  coccinelle: Add rules to find str_alloc_free() replacements

 include/linux/string_choices.h              |   6 +
 scripts/coccinelle/api/string_choices.cocci | 228 ++++++++++++--------
 2 files changed, 139 insertions(+), 95 deletions(-)

-- 
2.49.0

