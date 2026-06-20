Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C9367282
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962761; cv=none; b=pxfLBuQcczRJTGLeksk1WfY3rSaM9DCmvU7xCyxCUGxFno2Oimh28zMePwVUrXGbHqW3H7s+hyiZL6Udwy/yXASbTS2RTJKSUQ2trhHMV2K1Tg6PSh4GQkwZGuOjRx2MxM46Ya4Y/iEOsbqNXTpo/O5YYXFsVF7uf1f6Aw5bwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962761; c=relaxed/simple;
	bh=kKZ+f4357Y1BPzXQJi6nxVkBPThH/47/OZvK6zgvyw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsORXyPOniKTerHa1ZRJjtXNCtOqX5NnZJw7fjgCN/0H4dD9zr8yX4EpuvBhkNj15e0TJMOKb/i3aEfzsVoEcKTBCxGf8cj0L2Zw4edd4bgi8lgL8B3pCNUyrcE06e3FUkcCTwWJNLcC8ACfonmWvIK5eQg44vuh5Lw5ymxWMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=V2ALHtCQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="V2ALHtCQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4924593f45dso12339175e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962759; x=1782567559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGZqVsgClsg/gwAhFsRzhxT4x26EOSiWFsPamnF3cGs=;
        b=V2ALHtCQExaJkOm88K4eRZNtWO4BowDz6p/+kxDKUDBPWgVIu9Gr1yy6GXF+4br3D3
         urk4y5xEBEmu1w4ord9GnqfegchGeSHcZ9+dXWo6nNqSv5Mh++Z8uq/bSQeXyrSxmwIz
         cc7RY3++UpeZAEX8cJKZUK3OnQjRaPRmxx/r9/edqnEkzw8BI9G9+mGfVHL5h0e15lVu
         IQ11pf6iON2GaKSO2J8SoT5oHOa4zguI5LLflB/sQSrpuxSRlJl3JHoftO7+lf9hD9T1
         fFSCMUvt1FrADdmwKF6Z+kOn5nfCmhYqhehLNSsEUt0EpEgy0Lg4w/bVmF1aM+LgaA8H
         Yl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962759; x=1782567559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iGZqVsgClsg/gwAhFsRzhxT4x26EOSiWFsPamnF3cGs=;
        b=n5uWQM2OSk68Tyqi4jL6jh7bgHVYlrnk0GNHCnhAy8kPy2MPhRBA9CdBRNTfym725R
         fNH+qXphKqFlJO8auIqdeXYVYE6f/sHd/gU4XPHzzcx/d8KHd/X57TUVVlgN5AG2w4Ae
         wA3AdOwOcUd11pFBKpFIOMrJveyDQSTB2L1WBK/kNI3Ug8wAjYxdCNWtwd8njzFqjmxJ
         TQWeItNkJyey4aMXsNdMLDukIZII2eBp33a8a7KvuTx0wWh+F3iNjoiKAIuK7kU+llmg
         aUtE7HwZMj1YefC1yvayi6QTKcL0GB4JJzArLfsu8A6VFCYfe1ZEaASW/Ythhd6Fl1dJ
         m6dQ==
X-Gm-Message-State: AOJu0Yw3un98IUMnZpckw3AIfcopoCk6yNGV3C7C0cCbmRGbTlpxIlBl
	etqAwczC7s0s+QvGae3qvcx7L4+3X3HyO5ZdnkqWlbDSM/RLPqWUeaJ64qJ/wnIDxvqNI5FWA4N
	NMtB3zw==
X-Gm-Gg: AfdE7ckMgx7sryNHujbGzr0wcNmK6A0z2xdUAjprlwPO2JfgI/i1dYOCH9z9ZMffZ+e
	ha8WkKQ+pbd+WiY+iUC7v4xXaVbVbN81ZzMLlTsCa+U+ZoDxx61RmE6xpDqDUPfRtimCUmq7OLn
	qlh5nhvdTDEZcPjDcwck8OsX5XeX11yeHphv+EGyhTGA/LIEcVUjY/NCSq+pKMDivlPA3Qngxst
	/d2My27Vhe5vp7YueW2k93b7BYE4fbEgAsELhGS4CFO9fhYyKIKubQZPTgn4zoZzX9OZjauicc4
	3KpzU2gvPDduanys4UIzyQCxBi9hd4G7cEfpYeCtoicPK5UQG1agcpkOrKRUr3LSccrHZVDUqxx
	/Sm1fbVfXLxhmzUbQl+P2/Ni4Wddfsyl6pQL5mpNoPrFlokt+VqlhpTHPp9zvcTyYAldCE6YUa7
	zsU+/XozY+dhPbmauH+D9IuoOeZAbAUukZcAdW5WcFpSFJix/j4uSSUvSVKDpuSlgUxQuWV+hKy
	AC7Exhy9C8QlN4N6gmwc+RqUZh4
X-Received: by 2002:a05:600d:8453:b0:492:37b7:6090 with SMTP id 5b1f17b1804b1-4923ef51a7fmr137626515e9.5.1781962758930;
        Sat, 20 Jun 2026 06:39:18 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338dasm63525505e9.1.2026.06.20.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:39:18 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: Re: [RFC v2 0/5] Bootpatch-SLR: Randomizing Linux Kernel Structure Layouts at Boot
Date: Sat, 20 Jun 2026 15:39:17 +0200
Message-ID: <20260620133917.95361-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620133222.94647-1-yjn@yjn-systems.com>
References: <20260620133222.94647-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

as mentioned in the cover letter, I would like to provide some
additional background on the two open questions regarding validation and
instruction labeling.

While successful boot and userspace tests demonstrate that SPSLR works
in practice, correctness remains difficult to validate and failures can
be challenging to debug. If pinpoint misses a special-case structure
access, for example through inline assembly, the resulting field offset
mismatch may corrupt another field's memory and lead to crashes or
unexpected behaviour far away from the original fault.

To address this, I have started investigating a QEMU TCG plugin that
traces memory accesses at runtime. The idea is to identify accesses to
randomized structures and verify that the corresponding machine
instruction has been instrumented by pinpoint. For executed code paths,
this would provide a definitive correctness check rather than merely
increasing confidence. Any access to a randomized structure from a
non-instrumented instruction would be detected immediately.

I would be interested in feedback on whether this appears to be a
reasonable validation strategy or whether existing tooling could be
adapted for this purpose.

The other area I am currently focusing on is the instruction immediate
labeling mechanism. At the moment, pinpoint contains a small assembler
component that emits easily patchable instructions and places labels
directly on immediate operands representing structure field offsets.

Longer term, I would prefer to move this functionality into existing
assembler or linker infrastructure, where it conceptually belongs.

One possibility would be to introduce a dedicated relocation type. This
would likely require relatively modest changes to assembler and linker
implementations and would integrate naturally with existing relocation
machinery.

Another possibility would be to add assembler support for attaching
labels directly to immediate operands. For example:

    mov $spslr(1234, .Lspslr0), %eax

could be used to place a label ".Lspslr0" at the immediate operand
bytes. This could be a direct replacement for what the gadget emission
in pinpoint currently produces. It would not require changes to the
linker at all.

I would appreciate suggestions on which direction seems more
appropriate, or whether there are alternative approaches that I should
investigate.

Thanks,
Jasper

