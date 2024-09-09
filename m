Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C123741
	for <linux-hardening@vger.kernel.org>; Mon,  9 Sep 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922123; cv=none; b=Da3JpHHk8SwZ2E8rIOCgCUKZFsHXCjnLizfsORgR6s7UHejUUyxYHithXD04Ld8RA7mFz8SYNGECA6HO1QcdIRYCAt/hQZFbYlz8NIYeECY0KxqssRouVyRdZs6co3UMu26vp4CuzkN/dZqYBqs503jZlC/erAbPFl9irCuB50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922123; c=relaxed/simple;
	bh=rkdImjUZtrp4ImzZRS226DW6+1fYM9yBBOJuj2dWu6o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ElK+d+QnpY4Ne1qEbxZTx21uCFz0Z2qZHM4bkmRCKmDHs27hDbtVKKqfVSLJ+0tUwsignIEABzrlkMpJgxKY83t9NW85nArSrielyvARGuUTBFkOWuSYHBGpieORx4MJ/AqvqRcObPsvJitgi1MyTjZdEhDHyjjkA5onNpNwz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+yNb2kM; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+yNb2kM"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82cd83f0b2eso481840939f.2
        for <linux-hardening@vger.kernel.org>; Mon, 09 Sep 2024 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725922120; x=1726526920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NLDyWzTfZuqsLoIb9DG2Ov0GNSs+nA5mIhE6ZJufYmM=;
        b=I+yNb2kMUloQgz1J5RZqZrtDFuSyw4WcBY0P/JUr11mQeUJjWKmYrRcvXTny183w/g
         C9kwjcgDJmNssFRYi0Vl1P0ZskY85GxZTMaG1T8ijkel+Gmn+4Un27Ukwuy+NEOd37HF
         mcQ7zUrK6ctUs+C+R/0mEuz+HRdNgxuLIs0ycNpObZRcz2J8VVtJnivK186IL7pDLvYV
         PAVB129z87uiuUjLTsOjwyFPTzqivjbprktfPD5RZB1MlRrdAjRe9+EItPCtPCLzjXhJ
         qH99VlhYTOvTV8Kt0C8wYAMqf2xRJE+UGxbJigyX46Kxg81GEIwqU6oyg3QgDnjq+kD4
         T6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725922120; x=1726526920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLDyWzTfZuqsLoIb9DG2Ov0GNSs+nA5mIhE6ZJufYmM=;
        b=FCjDxlyAVPy68EWLF4SgZtZWEcwB694T5gByq1j7nHd8WRaQtcYC45yJZyOu9I2QpZ
         N+czG3WdhipnhmFVOWoYv9UaEu2CJl6qdCfM0uKrzroLiG16SuBdsJDA6gCJiSKNbUM/
         qy3Nryydp/goHvv5fBmRtkz4SLq5338zTyX4QYHncrknN4bFtebp6hO1929f41ekud5j
         tWLDW+B0XIxlg/SmF6dWaEcG6KY/jO8xvzaL8E2DweZnF/wgsQx+x/8U5G7cE6ZETBBV
         Ytzq8k0ZIbjXRLD1KOzekfAhqm5cL9ZrrK4XysP8oqxhc0U8Nb9yzivKySNTuSoeUhwD
         Xbyg==
X-Forwarded-Encrypted: i=1; AJvYcCVHJcLTs8HNziZzld2SW9pU5fDrpItMRFS8Ome7PQ4PWxdEwver7TL26kW1eT2SYmFKNIOtZ0N6vtg7o17ZbJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJExqY4k9dkj62MNpWqt3z6pA1lWitcs3keAI1SqnzoscqK/GC
	Dc2smUJ/MuR4VF1l9LFJQWKFejz1vILqK/RVq74UnI/1OhZdnAUO2AjN94e78SUd7n069FDCiMO
	z1VodZ7+HCMEJlKxEfxjzIg==
X-Google-Smtp-Source: AGHT+IHW9HlvXZZMt0RnOBn0kfRYjrcTlLFf/BWUyQHziXtf3ECYT6VFohieaTDTa3LBmOc4V5HiWGQM4zyJT8JI+Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:204a:b0:4c2:7945:5a32 with
 SMTP id 8926c6da1cb9f-4d08501de57mr562213173.5.1725922120651; Mon, 09 Sep
 2024 15:48:40 -0700 (PDT)
Date: Mon, 09 Sep 2024 15:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEZ732YC/y2NUQrCQAxEr1LybWCtIl2vIlK2m6wGNJbsIkrp3
 RvEv3nMY2aByiZc4dwtYPyWKi912O86yPekN0YhZ+hDfwwxRKzNNM9fVG44mZAbHos8GhtqaeO TWxr/TcYQiYaUEh2GE/jobFzk8zu8XNd1A/k72yuAAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725922119; l=2091;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rkdImjUZtrp4ImzZRS226DW6+1fYM9yBBOJuj2dWu6o=; b=RpBy5WGk7841aMAXjLBUnNV+WM74QAmVjxplAH9jkIJQv+5Ll3/fWHnPQ4vkG0vDP88xEPF8T
 nCGCLbpgdzoDWhCuqbZ6sFgO7Ai3Stk/gJZ1EJbZ9wU5CpMLoIBzPon
X-Mailer: b4 0.12.3
Message-ID: <20240909-strncpy-net-bridge-netfilter-nft_meta_bridge-c-v1-1-946180aa7909@google.com>
Subject: [PATCH] netfilter: nf_tables: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings [1] and
as such we should prefer more robust and less ambiguous string interfaces.

In this particular instance, the usage of strncpy() is fine and works as
expected. However, towards the goal of [2], we should consider replacing
it with an alternative as many instances of strncpy() are bug-prone. Its
removal from the kernel promotes better long term health for the
codebase.

The current usage of strncpy() likely just wants the NUL-padding
behavior offered by strncpy() and doesn't care about the
NUL-termination. Since the compiler doesn't know the size of @dest, we
can't use strtomem_pad(). Instead, use strscpy_pad() which behaves
functionally the same as strncpy() in this context -- as we expect
br_dev->name to be NUL-terminated itself.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 net/bridge/netfilter/nft_meta_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index bd4d1b4d745f..2a17e88ab8ee 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -63,7 +63,7 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		return nft_meta_get_eval(expr, regs, pkt);
 	}
 
-	strncpy((char *)dest, br_dev ? br_dev->name : "", IFNAMSIZ);
+	strscpy_pad((char *)dest, br_dev ? br_dev->name : "", IFNAMSIZ);
 	return;
 err:
 	regs->verdict.code = NFT_BREAK;

---
base-commit: 521b1e7f4cf0b05a47995b103596978224b380a8
change-id: 20240909-strncpy-net-bridge-netfilter-nft_meta_bridge-c-09dd8aaad386

Best regards,
--
Justin Stitt <justinstitt@google.com>

