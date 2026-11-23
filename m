Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443372;
	b=cCmGEQ4jKu7tyJhPeQmGvg1xlgUqTpqzD0RGEd1l+DXXDUgRTWBX0owelsYPvIort1hF
	 sTX4k7aXYRdbiahQW+bdwK7ERsiW5qA5+2OXAf2oXiQB6uiUwH8yYaukCT5+uu4mCp73s
	 odG9mSzCwfrw4ZNcHpcsaUDRbWIu/W0b/yrzvmSaTuxzyHBD4szEt1z7H2rMP4khveRSv
	 S5SzBoraMSXtbzDN7d3tL5Bpo5UWJWf6/MWqSV0ndlLGQaAJA4oNIik020B2QFls+qULJ
	 zY2q2HbjMEFVoYINAXVb5yX7XztgtRO1chYiTveQlztNFXRAKQJX4qYPMefU+zJAJ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q0kaLBG9armAqyKqZcboCnoBFONiD+mZBC8cBIH32JQ=;
	b=sDjG8HwZ4RB7EXUOFRwebGtfEoi81BADqA9ujg3cPlqc0/tS7ElOJHFcQHMFnVt9zTqe
	 ZgsibqoptWqQT2JY8scPZ0ZVnEjKgBFlwEhkXPDILORcrp2yTNwWoKvZ13mMXQzlKzvqk
	 5N9EFS7TX/s1d5GnkMgzHN7Erc89t53Kem1WRpw+9XyzEMH1FoQxsB/JeiWp8x8q445/9
	 he/3sBfVSwCoeEbrTMXmYBfeepd03sfkp4fWM8xdSXvigXuTSL54Knk60VH7zxtCGUUWz
	 9h5f+OA9kl0BGegF5NmHylQ+luTzgOG1xVfEKaM+xmx7+4c/RDREWg8KLzsRrduNHXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tc5r9Zpu;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AE606A339
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 210AE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tc5r9Zpu
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so2083212c88.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443371; x=1796048171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0kaLBG9armAqyKqZcboCnoBFONiD+mZBC8cBIH32JQ=;
        b=Tc5r9ZpuLoNZ1opGkx+WuPZYVISFpfhmuOmXh1fdY4qwY/bU0+dJxJl0OBFK6EJVLd
         4rxirb/4eLe6U4ldYzhnc74jNh8kXeh8UVTRffQzO/2SuDgO4Uoo39xmT7I/1RS5/b6Y
         kWc2ub/cL5QFYDNZZlNNDz1aDE/uU0XBdQzuAitfZEgKEy2jNkli27P9t/k+BZtrvWIJ
         uJ10GffCWAmoGq7zrOn146R73b1TJsxQYm71WeLuvXvS93qgxjDxwhK3aKWE0ALe1ods
         t616uj28B+sKZVa8XQWCN/dNNWky1tbT7yhOJeEsZ/SHSjpOO5+FlY3HD0guehyl9dC+
         G6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443371; x=1796048171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0kaLBG9armAqyKqZcboCnoBFONiD+mZBC8cBIH32JQ=;
        b=hlmaE2Kd5rhRS7H7+CDdt7UM5nIVOkU45Td+uIGLmvI+D9QJQYjCDxr6bgeVCjlG4c
         f0ls2QjSiRmDO3Npa670qECSps5+HQWxP5U8ke3Nm6ByoYxEKoyw4PjOWcMCkgk1k+iy
         np8Sf+MNKBTdgj7wn4wQva2wmowP9WjMcsbdQXzO6YfKev4D7eMeurJno0N8X+xjxtX9
         gcKP0Vug3/uDmouwPCZv51dNCOnOAatgE/UtBVQkcfQEexInWcEdQ5dot1ay8EUlHhl8
         4k5Z++8gdYLhGK/dCvIZPDT9Q7vmcHrdZbjBYPXvB4qch4Lwp6uRrzINiXofahxcphIW
         Nb1g==
X-Forwarded-Encrypted: i=1; AL+hErHqA8DnjUcToum+CkmdVS4p2t5pXJ8acumTHZMvSkuWeIGlBBKvgpDifnfR4kWseLvSNm5hdnBSEGE10pEQ6HY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1552UCUcqimZ2bzoH6pQjeAfk7L4igHjrlxSeUnGC+Cl1ZNfG
	vPjWZPidIYVtDKKRh/Hyvb2c04im3EUiazUx/m0MtfYU90pvUKdd2Qn6
X-Gm-Gg: AZFdTZc99wbNAD4VLic1m2A15atDh2NQziSDTiPkiek+HjYJVOIRqLGdi3WAaz5Ta8s
	qQJE5KunJcEMaXjVdupUdnz7GcoZn//fk76nSwNtIqy/icEpWFbgiyIiTtlydUnPzfgQehZmxVu
	yWOvCxra6GZ2DHOu/Lcfk7uBJC3gVW077O9T3e68wQWydVSTW+APl7ZX+93Bs2KkE0NuBij1kUa
	fhJMh587iiXZ+Euhn/A1IteHiAxwFlhYBoK6i/M2tlGQmIhULTj7yY9syCAtJ0iIEVPYDzThxb0
	LtQMP6qGAQgL7dJd8P9c8+BOBP7cN6hcz9B+NwbbgLYzq2VB5OMsS91tZGBvvPPusmv3vYZNMZX
	4KMCmfj6z3QnEiP6nRZSfROpsC4O4BoEDMg/opkGOFBJPuGIIRX0J/JJrOVtmgatymb6Kof8HUx
	plUsDuWy8sgR9sUyQCYFhtgLkeCk0FTsGePUHj5dd6Ge+TTWOVRVgn3FR2hjhMOGuz0xJxU/Wdz
	ARguF36+sNiLt2H4fN/GbYphn4SPsQnGiC3PaIYH3I05ZhyEtFDw2LPG7kE98HulWLFbKJkKLbs
	+otTzFom2kekn9Urpe5VItjP66VHmIkIQ0sJCXc9373oc0EPv2CJm5kuNMyIl+1P7TGUXw==
X-Received: by 2002:a05:701b:4558:10b0:1b3:b4cf:8f18 with SMTP id a92af1059eb24-1b556926cfbmr12460036c88.41.1795443371191;
        Mon, 23 Nov 2026 06:16:11 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm38348685eec.28.2026.11.23.06.16.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:16:10 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 01/19] mm/swap: remove unused parameter for reading swap header
Date: Mon, 23 Nov 2026 22:16:00 +0800
Message-ID: <9f3715ab29bc9ee4aaa1bb92bff47c7584b73ee7.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
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

From: Kairui Song <kasong@tencent.com>

The swap_info_struct argument to read_swap_header() is unused. Remove it
and update the swapon() call site.

No functional change.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d59fa8220862..c06f9f532e74 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3630,9 +3630,8 @@ __weak unsigned long arch_max_swapfile_size(void)
 	return generic_max_swapfile_size();
 }
 
-static unsigned long read_swap_header(struct swap_info_struct *si,
-					union swap_header *swap_header,
-					struct inode *inode)
+static unsigned long read_swap_header(union swap_header *swap_header,
+				      struct inode *inode)
 {
 	int i;
 	unsigned long maxpages;
@@ -3863,7 +3862,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 	swap_header = kmap_local_folio(folio, 0);
 
-	maxpages = read_swap_header(si, swap_header, inode);
+	maxpages = read_swap_header(swap_header, inode);
 	if (unlikely(!maxpages)) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
