Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E881F09A3
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754008; cv=none; b=piPI+BbOl4G2tr150WMBi/Fc72FHXeZINtBQ/+iKgIfn8+66/2tugn4hqKI39VumwK/o3kPbm8fdf8wPjimMlKiOecgkb3NKvnPw37sAwPkbaA2j1Q2BcBDJ0uJ7UjZLpvsGQj8bSU1DPmX338b2QyGY7MISgp+EYyhB+IioRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754008; c=relaxed/simple;
	bh=uyjlPQjCUIP3tN/i8tzIaK5s2tBhsnrdcDrEmNw41BA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=piSfUjNcSWddqenjLiPKHqOz2CJ5r+A4pJFEW9PVYGunDFwEquS/oo3lOrnnI/ZmKcdZggfE9JinnOEurqeo8GaEhfd9yyBi1TeCmSgonfzRTa8cQI2huD8O4vD14zn04UyPhA7jbZvGfJQWf9cxx7hfq0VKxdtS7xNtMU4BFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oh9GCWv4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oh9GCWv4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so6461120b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763754007; x=1764358807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVJsPQnIVZajk+lHlfDveIvLKD+85UYee4pfqF03cLk=;
        b=Oh9GCWv4CQANsIIeECxGGV0IwE5Tt9lptae69cWvOBMZ+6adQiRjN9lxB0OT3ZLKk1
         xhhj88M0EMvXh/m9k0SaihOtkWlZZ7BvEy2p23JtQlri04IrfhfTBWSh2XPKN8FyvIR7
         taxM358F45Y2UR7uY0IQLnDoxd5IXIdfysoDYAS5d9pXx1ERUb8+LYWU9w3uOfW/7uB4
         S6Z+mLgnVMhi+VekTPtv1z7WcF3SL4A2rDeIYyHUkD3+aNdgrS69kwpBl76N1xIpjAum
         KBOlbJAdMdU7o/q9SMV+OmiqKSX8+kggTm57fLhVT+fh9jSInT3UuomUrs/f2+tuGUB2
         2osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754007; x=1764358807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVJsPQnIVZajk+lHlfDveIvLKD+85UYee4pfqF03cLk=;
        b=t+nrC4qZ2VuJtuvDEQRxF+5QK9gy+ZQTzSJEbnM+gakhDQsUE0nsY0vlIz9VDJc7h2
         Ty8dR5vRd6i1KktJUXIDz9GPL4RBC6UZVS3W6qYb7K/5hnTz3tm/TjGcoQEk2kIOlQk2
         wKAXsxFVJLsVAqLDfiyGBJNE3mviEiSC24UU5DJjj+CHXoAhMMuB2KWU9af7HkfAQ8D9
         //cNmp/3nt0HlVl9Tdgnuu3gTpJ+OCHJumMJgA/h9xMTXm8zIEiLnPdsM6q2dh9fQ21A
         7esl2z9WxcKSMmC9/qfmC+XS6eBDfR/rCvMLKWX9QMcIV8fSlkLQTRMJV2c7k76KVi2K
         Q+fg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ygt189IGvgkF/cookwibb1hDwuGlNHAaS3zZ0JLpnRwHVaCY0qjEwrGwPhcBKT4FDTuWdlniSv+0KNo9RyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dcNPcdQCZUkjUREKAVNRcvZEuLlBqqeC83FlpLJrfxekm8Kv
	Amqyl8N4+hcndR52+H+wUZiJFgS2Ibv/rHFN2ZpnnNgMzFTlvOkUvYwpY+7eS2mDl9EjhcDAD0c
	y
X-Google-Smtp-Source: AGHT+IHarLcIknxetIYeUvDf3MVSiAq41e5Mrh95YVro6zYarTxgqBJdpBdWXVnAePgCSrupRn3actC+TQ==
X-Received: from pfbfa5.prod.google.com ([2002:a05:6a00:2d05:b0:781:26f4:7855])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:158a:b0:35d:1bcd:6882
 with SMTP id adf61e73a8af0-36150ea818emr3944453637.23.1763754006657; Fri, 21
 Nov 2025 11:40:06 -0800 (PST)
Date: Fri, 21 Nov 2025 19:39:42 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121193957.1655580-1-morbo@google.com>
Subject: [PATCH 0/2] Add __counted_by_ptr macro
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

These patches add the __counted_by_ptr macro and then uses it in
mm/memblock.h. The name of the __counted_by_ptr attribute is the same as
__counted_by, but two different macros are needed, because of feature
skew in GCC and clang. Once the minmum versions of the compilers support
'counted_by' on both flexible array members and pointers in structs,
this macro will become obsolete.

Bill Wendling (2):
  Compiler Attributes: Add __counted_by_ptr macro
  memblock: annotate struct memblock_type with __counted_by_ptr

 include/linux/compiler_types.h | 11 +++++++++++
 include/linux/memblock.h       |  2 +-
 init/Kconfig                   |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.52.0.rc2.455.g230fcf2819-goog

