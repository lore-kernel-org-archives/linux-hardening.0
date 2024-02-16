Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30917BC4
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126070; cv=none; b=PK+pnYdEhijCLGxQYfQXIlTwiDG66vu7LAAEN3u78Q1+bpTJkFQBDPOxNlCaBTPxxlqkVHpHf0ggEaZY1EdVSNpAl3hPCTpGFtT/rzG5poPhgEL1mxX46iaYWv2oNG3hsrn2OSKTn/0mkR8WrNU1InjBnolycjakhHce8l6wj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126070; c=relaxed/simple;
	bh=RNT0g0cgXQrcIvbNgrkk3LhFhJNchXw4WLd58eWGTyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3Vj5QCMW+UO7j4By/8jXt2OVMp/Z2G9UnuJjpb5OggW0PEGwCTxSRlCOhV1/0bVr4un5U5ohCuyV5pF+3MuPRYabHO0pPbaq9C2Ky3PGalV1E3YF0mhmX5C5N4R+0idmfc4F+tykhY6JVGQ7M4bu+c04hJZ8E7IOtgmajDPwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SRBq0NJN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRBq0NJN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2124521a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 15:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708126067; x=1708730867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLi9PHtxZsuZz7e5RQdykX5MWOEl3dE9qrCPIM1hrRo=;
        b=SRBq0NJNtAZ6jpCpaDoDq0gS2MIV1sFPCquA0NnTAn0Bn4+TCURcDgAjIDwJ5oVser
         eeounGyiNP722gPZ4vqG3zFwHZeCT5zHIZZj/QNwLUB/DA6U5ImtNn8MuYPeAyPRlbzK
         /OVmhGvYIXJeeObYRBrFPapXbsXeD2Yx0EVHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126067; x=1708730867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLi9PHtxZsuZz7e5RQdykX5MWOEl3dE9qrCPIM1hrRo=;
        b=vRe8xYBjHVM8YfF2pyoV2loUU6eZiZ2ghMOmWeG6d/vS4VSWkWx66bsdnSzWh59JFx
         Ke61dGAPCaOnOKS7RKG16T++gYY1V4APy47h3rCMe0p3SAKN+Yi2lhbMlenK5kxns/Dc
         K8JIdeHwXzyfRbe0d+NmCcyXsmkLo6Prjkvn48n0WQ5qlpfQc9qCRcvnj6MjLo4NGdVp
         rfRmV/cacrMF/l4rfWDci1d/AJnlZsRsqQkRO7bTHxu6d1wzuwDVbLHNXO+bPEGmh1sI
         zZ1EQu2a6ki4s/iv+IeIQUBlZnZz2qU+dE0zoESuYE0df/ijzwuH/ILxft6/NhNJusQu
         9X9g==
X-Forwarded-Encrypted: i=1; AJvYcCVsaQaG1irGSJGOaF4wcgHr1AtcYV/Az2Kf9sX/VsScQU0sY5dkddrR+0zMFrlNjIxp2JRYWUzLctRxtFuMCNtGpUKoSiOQGw57kWS7Jl4R
X-Gm-Message-State: AOJu0YxnQLhY/cHzS8zGx6362UYmC2zhWviZrH+aLu4J4yV2/KyvYWVu
	aORTWUG6rozOnzIhDOWBaNOtnAAhllrTqMx2u+x8Dsal89nbymEcF8aOVFyPlw==
X-Google-Smtp-Source: AGHT+IGPCpilatN+troOQhhuhZJ1ZyJIP1f1BukTAiQCIoKk/LNCdR5GS6r7rJFOX+rcu0p3vRbu7Q==
X-Received: by 2002:a05:6a20:4fa2:b0:19e:a9bf:d51a with SMTP id gh34-20020a056a204fa200b0019ea9bfd51amr5455247pzb.32.1708126067651;
        Fri, 16 Feb 2024 15:27:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d8f82c61cdsm369379plb.231.2024.02.16.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:27:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] net: sched: Annotate struct tc_pedit with __counted_by
Date: Fri, 16 Feb 2024 15:27:44 -0800
Message-Id: <20240216232744.work.514-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=keescook@chromium.org;
 h=from:subject:message-id; bh=RNT0g0cgXQrcIvbNgrkk3LhFhJNchXw4WLd58eWGTyM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz+9w9qSnRo2mb+YJM+Gu1IwPUsAtgHSw+l89v
 SbeoLT1YpuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/vcAAKCRCJcvTf3G3A
 JgMGD/9xRXBIxLCBH7+ga8H8o/WOsCi9LCOVzwWZDpHbh6TZefl0ftvDhBHx7fg1n4l61k6f3w9
 1El1BpQBebgi7nX+Ets4Ub4/N8660HPXoRbAz6As6Ne5h8z2F1kw3ZBn6ITb7uqN2izMxRfy3/T
 8XA/eTuICYCEYDIQa4FqnmhVLh6WkR8mN0/N+LTAymXxd00ECGrhXlJW2dhrUhhTbhkzdvUF3WB
 XEWJGtf4nP0kA3omfRN5CDGZ0YjDY2GS1mKIvj6eoJZrXXb+a09jCGPm9Y7qU1MB0F5A8pVlwNF
 hK3T5yvnAdsN2FsboC223ZEzRd9XnGjM+xA+ZoQtpE5cKpu/HX80H11TmqAw/RZZtwbycKZ3MN1
 VAlI70Igu9n71hjMCRL6of2MjZud4bPUAduFb42FOvZvXqiKkkwRD0LAy0+R2VX8/KsB2E4TrUA
 vKh4f615Zd5qR3DKd3mjl1F5VnBxqa7oW67YYU/f+MCg86r+pT9RYj3Yl2tLNnjtBTLG+ePv8rK
 otI00CvwQ2/R2IU/zEL5jtJqM9y+xTTP4Y2MVa2Mv/3RJSPHSSV8x40Hrpc+RA6rIjMFj19BWI5
 oKc5WEPBofLAACgXz8fhUrXfyuUZfg0qeE0JqzukNFzqWGCbGESpOyHoQBYnslPSqhqGdZ3oJjl
 TVrnnPI y3rX9jFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct tc_pedit.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/uapi/linux/tc_act/tc_pedit.h | 2 +-
 net/sched/act_pedit.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tc_act/tc_pedit.h b/include/uapi/linux/tc_act/tc_pedit.h
index f3e61b04fa01..f5cab7fc96ab 100644
--- a/include/uapi/linux/tc_act/tc_pedit.h
+++ b/include/uapi/linux/tc_act/tc_pedit.h
@@ -62,7 +62,7 @@ struct tc_pedit_sel {
 	tc_gen;
 	unsigned char           nkeys;
 	unsigned char           flags;
-	struct tc_pedit_key     keys[0];
+	struct tc_pedit_key     keys[] __counted_by(nkeys);
 };
 
 #define tc_pedit tc_pedit_sel
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 2ef22969f274..21e863d2898c 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -515,11 +515,11 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 		spin_unlock_bh(&p->tcf_lock);
 		return -ENOBUFS;
 	}
+	opt->nkeys = parms->tcfp_nkeys;
 
 	memcpy(opt->keys, parms->tcfp_keys,
 	       flex_array_size(opt, keys, parms->tcfp_nkeys));
 	opt->index = p->tcf_index;
-	opt->nkeys = parms->tcfp_nkeys;
 	opt->flags = parms->tcfp_flags;
 	opt->action = p->tcf_action;
 	opt->refcnt = refcount_read(&p->tcf_refcnt) - ref;
-- 
2.34.1

