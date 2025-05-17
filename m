Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C581F473C;
	Sat, 17 May 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747479049; cv=none; b=H4+R1YBQDz7ENqkDR4IYdmuIRxSp6uXkWeuV+6HB4tgwekIn2bH44q4EnS2IufElhuC7HTFWtfLs8dBitynm/tuJPN65/4kqu4ucSgxejHxr+XUjCkFouTLsZGdLph0i1AZFLau/oulWt+wcMB/d6HJKlMLXpB5GWfPh/T4dQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747479049; c=relaxed/simple;
	bh=gTe1bWFz2aeZjA8xm0aK+6a85+NBSGps8O1zizoWqow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mno1JXVcb2LX0uGGysjS5yLlWmKQzu30+3kbH6gQcbmDpJX8LCFhk0rxLx3Ojf3uIxZDgdJtFxJaK8dV4u7WFFUeYFQ5qdwXoJYm1HwmS6lc5PPGD8by57eC+NKqe+NHiANTdXi37WMuLsbURSaMxZQF0i+xGBriDqPEQ1bUc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4b00Lw4Q8Lz9sWd;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAQGIddjf2x1; Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4b00Lw3gtmz9sVS;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 778DB8B768;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LHtpXwaBRXOP; Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 40D948B763;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 54HAK3Eq013312
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 May 2025 12:20:03 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 54HAK04l013287;
	Sat, 17 May 2025 12:20:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kees Cook <kees@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sean Anderson <sean.anderson@linux.dev>,
        Camelia Groza <camelia.groza@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qbman: Remove const from portal->cgrs allocation type
Date: Sat, 17 May 2025 12:19:35 +0200
Message-ID: <174747706460.12970.18215881041765719309.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250426062040.work.047-kees@kernel.org>
References: <20250426062040.work.047-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747477178; l=823; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hNTrwDECXwzB0w5bCYwkYV4UpWwqz6HdVtTVORZF/Fw=; b=mFKsjfXcvpGeGE31KGr09d6oDBkiSjZI94a2MDnCQHBHukcnmeqcKT4xhZFmPL+AOOsVnsPBU ZAVkzoD/un4B/P+9R6d8wR5yHjP/i80Y1UZC5JifRFWXwlPuejDEQbq
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit


On Fri, 25 Apr 2025 23:20:41 -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct qman_cgrs *", but the returned type,
> while technically matching, is const qualified. As there is no general
> way to remove const qualifiers, adjust the allocation type to match
> the assignment.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qbman: Remove const from portal->cgrs allocation type
      commit: 5ddac92be4209f29ec26b3ec59a08fc76afe9ab1

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>
