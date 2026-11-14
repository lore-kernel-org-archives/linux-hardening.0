Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667749;
	b=uXp2IEbEl2MrmdP6TkbX5/AgkKNXVh5fWhjfOhOYG6ty1DDlyzW7gKcUObfZTVs5A2O9
	 V7kBU/kN5gGbbGkkL2H8SntX0aK7ihRnS9n0VxHSqDKZZ57Foz/AEwGF8oI8odpiNLxxE
	 0o+T46/Z6KCckrIIQRH4RXTfkMUbuYWSEqpCl/WP2+tF39g5lh9Zb4n97C6e1OXDS9+b8
	 xR5ZpYqxdnNmUEoEJBER+Xw4ytu1rfbHv1s9rfxjpMWsCJlWQBIP8rAdFA3jnPVGRyiJO
	 cL6jL4+csd6qMoEtFd/hslIRCV9EwJkHr+mk2F8MKp7Uicx9/5rgRFtPiKU9oq6m4PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kzMIfhwwfaK5hfbFxkKSCWJeCOa/IqQHzX7VS+tqj98=;
	b=tqJ3ZLJLtODo3rqLMPn90FBAeX0GuVRS45SQxBzF5BWpUcR+gTmbJ36ynoP/hrlcmtSR
	 uUda4OzxUvN8a6CMm7AI3sNqZQztAXgn0elfxAHgUSKD4MmIj42k5FvBWXMBdT8LPO1wX
	 6sVVpO36/0DScEZ5+ZoMRDI8k8XDFGxpyqmbdnD+x6EEUEiRotlHtKKQ7hCMaCxOIgsdG
	 7dCdtSyZ7Ef87TjbcEV3/I/DSiHN/jCq/QAxJ7VPsmMyf1VtqpIk529WrUQN0Zvx8RrSC
	 SBePyabrYeZD6at4w1A1yyCDwTWnklLrveepS6VX0q0FecO/xtfoRUFUSWwGpPCVHxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifOh9Avd;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86007606A327
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86007606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifOh9Avd
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1056416a91.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667749; x=1795272549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzMIfhwwfaK5hfbFxkKSCWJeCOa/IqQHzX7VS+tqj98=;
        b=ifOh9AvdysI02x/7wGxbOweJHB+EFGMiTV/MiQFc7hkc53L1etsQEN8zVhUu/vqFhJ
         jdx9MAJ6D7/6TcHDR6GiUrRmzL481bWSZUXGCs2+D2DmxeTSJ97xlQBG9Yt7NXNEBBYC
         MDXidsA3Nuhd9kXe6Lq8A5MKIbTnLoVr3PQbYLCu87d7Rx5tzs4iI8rcDtV6dVb6TQ/2
         osFZ9QcEKYDcN3wYqVVuzZnsBnNItHtYnd4hZMW58SGxfNeWaCENAb9CoM4yGilW/E+8
         f0vusuxOaubHtDt20WJ8V6paIme9qf/sbFHWrjSYdTwAKUPdCXrHPcxpnxmZQRqpfCBd
         dpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667749; x=1795272549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzMIfhwwfaK5hfbFxkKSCWJeCOa/IqQHzX7VS+tqj98=;
        b=cGeFD0zj9tYbGfHy4nUHrT1mUUooOh4P0t+Tdn/c/KHwh5ljc0Fl83KBgFbyC9Zmxk
         xDe7GuuWz+Nf2PzFQoSRrDCTUuNgyMYQfwQu6YrMa5idjVz+kJ3PgWmQT0pSoUvN0bq4
         /bcpT6dmGWO+GZNpb3JHq+9Hx9rT4nfhDz0GXshoylkw3sBds+CaqqvG/eFtzHWE+B9v
         H06hwhOTVbf5z51k8vi8OXysG5Bf+Ka42DXNEEIx4eoOGe7lWHgK/Z6kWOQOehLyO97l
         A1yFApeVucPR+c10xks/sKX1iXTBj7S04oByhNizyTNKnsPCMMSwSt0gOw6R9q5elw9h
         x3BA==
X-Forwarded-Encrypted: i=1; AL+hErFEff7/HmIRu9gHd9w5zob/wRyVJy6eity30aR7MKJ0sNjKHXt9NFunJiMkzTn0iy0vzUn+1auhbxbB8xm77u0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UsAaBcZ/JYJccGFKeIX6rJCKVo+V8lBKBH+qt2FFx8n3Wumi2
	bZUWrEhP0uUocO3+vCYzQtHt6LOt2PtU067jEaCNZj6pvpQXzkHCjWyl
X-Gm-Gg: AYBFou3Whj8EMEJNEITLEL7ho8UEDrx0bd1MUiTwjpFCZcx75qSdruzhN/5vO8Ytqpn
	alVktKCrIRNH9+cQMcd1+/n+MBojmk6qE0Ok8kgPKUfuAzRvOkcnN8ycFwTs6QYG0fQjtD2JJfn
	ZFj2A5vl7OabNys8E6yDjRkSzn6Uj21wAWo/SUhywBtTEMBlhhbpzGP/fp3vXHLlBlgMnckmgFg
	Yl5xKDTPiQvKeIgnxLjatdqQGUvBdtqQ5fWvcRooLQWe+/wzdg2ICj18zu4jJNPDoATcQ4P3jHk
	mCsk5sO4UwauLkx3HzYUnTJKO3zvMJjgFU42xs7gOd31CB4TDlmeymRIS3ifyYqwgtD7YPTBypa
	Iuqr2Rnr2fvXY6PacpnpZNY18RUHZrovbDHVdQ8+WO/AEofkiPMiMKUIb6V6QKdMBIAZ7tb73EI
	+Zb0ZMoUgtda3W/k6dQvwgXcYQmMSHEiExrDHxSVSqor+xGUDXvBXpE8QlrWlyiCY7Sqfs4GDIN
	BE8xIvqe/dEoPRF0oVDhZAAtujOWUfb/fWrMcunTtwBF12JnHYRTqyy3vJQxIas53LFZyKM/v7N
	YeeYh9e5L4CPwv2BOiJ3gi1yM6k3Eou+xkdYkCJMEB0iGKdGThO3K4uRx4CH//couMQR
X-Received: by 2002:a17:90b:39ab:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-3b1b0a0e87cmr5694907a91.19.1794667748842;
        Sat, 14 Nov 2026 06:49:08 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc186fc72sm2599953a12.5.2026.11.14.06.49.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:49:08 -0800 (PST)
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
Subject: [RFC PATCH v4 01/18] mm/swap: remove unused parameter for reading swap header
Date: Sat, 14 Nov 2026 22:48:58 +0800
Message-ID: <f42af36d7ec66fb36fb7024966f4a7114f338a77.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index fcda5eba1714..c41c4d26a7e6 100644
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
