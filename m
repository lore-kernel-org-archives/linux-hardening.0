Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED375449B29
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516566; cv=none; b=eLfGFfzGOgAXfRK/Kq5VgnthbAgOjJ/9nv9mYKjPe+f7cFk7KrkADpoMoSaj2MYtEFZrO6lL5010EQ4JrWf7nNT3FNs6hWkdG+S6ERLylGllgnB12nDw+8dwOt4H4TzNBqvhsWG4Ek9fNmVTMfjJvz+qWmeEGm3GPZByTAjoiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516566; c=relaxed/simple;
	bh=ZPTK+D9yB4z8gSsX97iV+kjGxTz2CssU6OP6vc4egpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wvrt46T52X/WbI4tLFmkFRQVlO/XFMUA1rHYmt9i5dRB8purrQb8sC+VjTqnVMbvHx2nCa3vTXBTsj3wmuoXuLLUhOJ5NKYJO04mlxaTuKdbixeMXtUuEhLjJYD2tYcU7HW9tT/0fJlLMEF2AT848IpLENoe7UPmUNONg++OM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGUqMFl5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGUqMFl5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d5335cf904so7724855ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788516559; x=1789121359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkDl0Y4zNUnFCr0BpcsL/xKlNTA0whYo8hcoWC1r1Ck=;
        b=XGUqMFl5hBteE0sUv0SDEcPgRiKQTuvZMuMht7c6lbAy+oHbNHnV2xPd33AbG9NYe2
         AsSACcpB8dtmZVj50IBi87V0qzAi+6R7fE7AETlqRxoABP4o4xUTycuUZe+OAaxYQbVY
         bnvlIFe6JhmNZfp7ayoFAndP+S0tvf5mq489aYuvt3wNuqHBwkd/07dRUNzrvMzNv6oe
         Ki4SE2RJ22TAduugKnQW25Y6iPWjcyp+6xgPFqL1kvPikfpp0e26KKP4luxGiqJjM26m
         i9yT0DlKRB7LNZWCKyxKJZBMEpBBSr9xDmDRdn7AhdMNJWAW5bKOYmgwDnjs1IrQF/gz
         gbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788516559; x=1789121359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkDl0Y4zNUnFCr0BpcsL/xKlNTA0whYo8hcoWC1r1Ck=;
        b=NoNTuc6l5e3q+U1zEPGNZ6D3vAy+HcaugqoO0tNEyXjJORUBjjhojOTS/8UNHHMolj
         Puj35KLe2F9T7eca8GxKdymLrSQXyNXywPE20/Ff9zhenanEXRyMH5j8QACSh2H1qNPL
         QwkRd/zSqgfCV0lkvOtZJKdnpPUZao2NNJ9NR1uWjrYvII7tvB2Chdv5Amd83EN5ZTCr
         CgCyW2813K0ge0iX9FERlaiEfZ/jYQKfdxsHsxET3vG3sobduLn+bAxptzg9XVrMC6XP
         UiKOfFFLJV0kRyMYETrNZK5Yr8Grn5/4t3fJWRdgBx5mjK6TT867LUZckOBYAzCkEaTJ
         9ltg==
X-Forwarded-Encrypted: i=1; AKwUvBzojk4TfPIjad7qhIUH6XoTksdPgG1OmPpxZgiZDqYieAFIBkxdF2QQaXHtrMjtwKH0s7hL0SRnoW0LjbbWIqU=@vger.kernel.org
X-Gm-Message-State: AFuF++l9ZyIKp60zuV5SjxAnHTojjbUnM7CDq460nCJVN/8fnWHi4KvL
	rJAblUPlIdKkbxAraoLvIvHkrLh7I5ZgGM9RErKF8Y1l7xZe+gSH7kr0
X-Gm-Gg: AYBFou0yUDqgM3MEycvEGtFXodB9NZ/VGGJ7WSqCTzflhCfsXgVDnhVQ0IHms6D9KtT
	9/RHKJJ/RAX2dlHLOKWdZXuPY8a95wNSB0dorXnadBYv1W5IN55McdwyhgVJ6vOklQ6/GyUtmiQ
	vNqk36qHo3GvmV+giYLElRrhM1W5HHZHEfWf+DIxUMzTxjisUe1Sszfl7n2KPIX7IoKW/HWNQDz
	ExRxBpChmfqIOnuLDQh+tZs+y5H+qsc4Uc8qjovvPOGPbtE58RmcEm6suRbVUhIfxSUWXIrYhlx
	6gXUD71QZFF21P8CTEojWxHkaGs3SfzUhSQLxlLfROhLfMxkb4Gsy9UiRFpnSvr/FwBPycYUOuA
	ZZ6CtUmrblm9jnIIlP2bEkJ5NZ5ZeaRrBLLZ/v6frsrhCHPDaCIDEeflSfmRBNF0BZVV30f+RFY
	gv8T8a70rdErWK5SaDHQWcXDUZ7vBWtNtLs4v2914+ifV5Qe7TCweI/xdyE5qPVcV7NRbmZsLla
	8BB06oNbHUYGDL9c1LRG0deYT0l
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39b25ed34f3mr9006849a91.0.1788516559196;
        Fri, 04 Sep 2026 03:09:19 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm3692904a91.13.2026.09.04.03.09.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 03:09:18 -0700 (PDT)
From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 00/13] mm/swap: introduce per-priority allocation queues
Date: Fri,  4 Sep 2026 18:08:49 +0800
Message-ID: <20260904100900.21517-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <appvhlPleahTRklV@yjaykim-PowerEdge-T330>
References: <20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com> <appvhlPleahTRklV@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 4 Sep 2026 16:13:10 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Since tiers come up further down, I'd like to raise a point about the
> patch subject line too. As Kairui mentioned in RFC v1 that we would
> stay aligned with tiers, would it make sense to frame this RFC as a
> per-tier allocation policy (or something along those lines)? Kairui,
> what's your opinion?

Thanks for the thoughtful feedback and for taking an initial pass over
the series.

I agree that this queue could naturally become an in-tier allocation
policy. For this RFC, I would prefer to keep it separate and scoped to
the existing priority semantics while the tier and virtual-swap
directions are still being settled. We can revisit the subject and
naming once that boundary is clearer.

I will also sync with Kairui when he has time. He has several things in
flight, but his view on the ownership and framing would be valuable.

> Devices assigned to the same tier already share the same priority, so
> I don't think the allocation policy needs more than one option for
> that case (I can't think of a use case that would need it).
>
> 1. For legacy swap with no tier configured, define it as a single
>    priority treated as one tier.
> 2. When priorities match, allocation naturally falls to a single
>    policy (not a queue). the concrete policy here is this
>    queue-based scheme.
> 3. When tiers are enabled, devices previously assigned under legacy
>    swap are reassigned to tiers at runtime.
>    (This means different swap device on same tier handled like same priority device)

These are useful design points. I would like to study the concrete v11
before deciding between runtime, boot-time, or compile-time tier
assignment. It seems safer not to bind this queue RFC to a permanent
tier interface while those semantics and the virtual-swap backend model
are still under discussion.

> I think this feature will also be needed on the virtualized swap side,
> which makes me wonder whether this patch should go back into the swap
> tier series instead. Kairui, Lian, what do you think? (Or separately?)
>
> I've also been thinking about how to move the tier series forward
> since v10. I'll prepare v11 shortly.

I agree that the mechanism should be useful on the virtualized-swap side
too. Once you post v11, I will study and review it, and I am happy to
work with you on whether the queue should be rebased onto the tier
infrastructure or remain a separate policy layer.

> This is the direction I was hoping for. (TBD)
>
> Within a tier. /sys/kernel/mm/swap/tiers/<tier name>/<policy name>
>
> - Across tiers: allocation follows priority based on speed
>   differences.
> - Within a tier: a selectable policy applies.
>   - The default policy is this series' scheme.
>   - Priority-based distribution should also be possible within a
>     tier.
>   - If xswap is introduced, its allocation should be selectable based
>     on memcg.
>   - Other custom allocation methods (round-robin, etc.).

The split between cross-tier selection and an in-tier allocation policy
makes sense to me. Keeping the current queue as an independent mechanism
for now should let us evaluate it as the possible default policy without
committing the tier ABI prematurely.

> No regression is great news. the plist refactor is valuable on its
> own merits.
>
> That said, could you also share data on other angles, such as lock-
> contention benefits, or advantages in other use-case scenarios? (I'll
> also think about what would be worth testing here.)

Yes. I will add direct lock-contention measurements, the one-device
case, and higher-priority rings containing full devices. Let's keep
sharing results and test ideas as the two series evolve.

> I've done an initial pass and given my review. I'll keep providing
> feedback as I go through the patch contents. :)

Thank you. The v2 code delta from v1 is intentionally focused. If you
find any problem in the individual patches, please let me know and I
will iterate on it with you. I also plan to spend time this weekend
studying your recent v3 swap work, and I look forward to reviewing v11.

Thanks,
Lian
