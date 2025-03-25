Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276C42A9D
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867784; cv=none; b=YPnNglRz2j5BGCIvdRpUsH7+CfxcHCMqPl7WrrzNhcCTA68WGzZRwPYyFSfLC+C+HZX3ZMHjgRV3hWw/FXFNkIUCQCue8Da/xaG/yvqjO8/xUjYT+dk1vKH4X2tB7cEdILBdJREXai2nht6hmK8Yu+0RdGcrYqbgIIoeHOL1Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867784; c=relaxed/simple;
	bh=iW8dJ7iHFc7kJ17qorglPOnxf2Mp3LzySJvvS5iXDTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LQQ2ubcXVkGS1pkGsWBT8urBtDIe7buEkSjKBstX9ueA9/bj/7n1CV08L+l6Zsd9IUXValnhfAdeZ8GtVOTrLf3zuXB7ocLZBpd7qjWfMCtk8beetEljG1pY8hYqf4OF9VtcF3A6Uj/HJlg8g+mO4Q0UWW4pyOVrj3rCwVerN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxhG3Bd/; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxhG3Bd/"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2b83e537ec6so4484554fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742867782; x=1743472582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ib9+Q0ada4H11TeWZKVSJ40rZdGKNeCFH54Ppv1IWfU=;
        b=rxhG3Bd/oQeq9vCDpIIsJO5JPm/nxulyfNTPMcCvRr1Q4JOVghdI1OSh14lmgQIXOv
         DMRRNvNrM1k75JUQQJZ0wjICYmuzHaa4U2oY1oGN6HhVRoWnh2XEK2vDt4D5MyiySZqs
         lAl4H/MaD6QJV2KlwuNEcGzPIivmWM6Rel74+3Wagx0BdlxqIQhmzpUSndlDbE3HmAVf
         eKqdGsR+O9xDPqE5ghb9cAd+zPsukv1x8hvqrDd3VObrSuTC+Tlj4UAcoKiewotdJFiv
         XihQz1TYd/khfjK19bzXG20DFoyql/EUB/WU8/RuFGqr+9XgzUDC+FAZBr9FoGa7Q6GL
         ubEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867782; x=1743472582;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib9+Q0ada4H11TeWZKVSJ40rZdGKNeCFH54Ppv1IWfU=;
        b=FROJeW4b2GD+eRVfHGBFt9lup97ohBB2IY4Zd34k+5DwFkk17R6+8j9ejy61NI8Kw0
         DEBKb9C6sdE3M6WUihW5UuyDlueuDl4xbvEtQXLHDBys9u9qVub2Uf7sOBb3RWy4SRIt
         7Iw5ycwseXRwp7TmXPU/9WDd7Gx1qrpZdFZEDT1/lDmJIB8LsdnJFCSvI1HmcHHZwk6u
         xme7WSEFGfkEe8Xz9YkvsplJwAioqBrxe92nsuwJOCbMA+cQFZB+OcUBAtHLC/kiktLB
         qzFpeFRg7fceaXU9S+AyCbLhNCGceQ4CxOD34K45DivCRPHL84Qj8x+GFEOYYFRY+52O
         4TEw==
X-Forwarded-Encrypted: i=1; AJvYcCVxFGxh45eb/EP2FANoYzaDZSSuZBYLZk2+tuAgv3chE8ZW3HZSEkOzT7ApQN8DB3ibWhE9tclPLXEv+rOZggE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dSzAeStNAJmL7VEpdjpmhwoSs53kEoTMfmgztZKgbRsMLxtX
	2+RuX+q5m0NN50fjCxZYFHR0xKpIj+LstXBmx62u3B7NdGWvfmUN13jkdB1yk6TgVw==
X-Google-Smtp-Source: AGHT+IG0+uLGPYG9slyIicgnfJMvJ/fL3LCjzaIbzQaDguDS59/5o4ooegKCdV6c7y6nONpb9SxgUdw=
X-Received: from oacpc8.prod.google.com ([2002:a05:6871:7a08:b0:2b8:faad:4f1d])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:e496:b0:2bc:7d6f:fa85
 with SMTP id 586e51a60fabf-2c780298b2amr9783186fac.16.1742867782106; Mon, 24
 Mar 2025 18:56:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:56:13 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325015617.23455-1-pcc@google.com>
Subject: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

v3:
- simplify test case

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 13 +++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog

