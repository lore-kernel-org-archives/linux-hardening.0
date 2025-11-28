Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC132D738A
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301155; cv=none; b=nB0nlYvVkwj68jAitu7w+oCZ7XcnJehRx39PmFojxYLQIO9IaQFjjHtre1aLk+VJTyL7CG2bj86XF8r/PVg9uto+DybFMKk6sk0fm4svAlE5jSlyBMv8Wf8HHxc+euq8bFN/dCy46Z6M2w1gEdrvWidFMWnWa+dRHxlkQRai4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301155; c=relaxed/simple;
	bh=MJtcgcMVRbYqnz7yUeXOqkpQ9bJ6N+uilCKOuFcLl7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQWj9ryFHfqi/KqhASO6DQNNFFvNZTbqgUIiWSUFveDwAir9ON9G6TOUrZQVtVp9JRXGepliuxBPlcRR1LPpKKCfuHqIex9KbTUUoXZXI9FUMp2iRfBUnVeB9V1mbbvu7N+RCTdansj6wLodw042GPD/R+ISzmToH0Uec5QFc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNXca38o; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNXca38o"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso2958683eec.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 19:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764301143; x=1764905943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXLSGxyqlw9PW9NDqgFwLCeID+cibWsbL+ACEydXwXc=;
        b=YNXca38oDHluT8SnWtE8fYPvLA0bnx2/Aq1SAToE+Eg2S5+oWjtbsS3qFMc4Wcb75+
         ev42RpVfVNR/4+LsMANrg1tWuP3HWKRTqxxgUSV0pnrJLMpnjJfuc/kwmOVars31nevO
         Cle9pCOGPCevycQRlUWY/tkG24d3Rou1fDleTRNN37uImpB1UcLUoLFBIhXxAGRheBAx
         QGjPnQTkgRH6TL4GIK+Zcs5z4RVcjyxuBiSAEj6dOkUlJgpxgLmmVX7t39YDnJDoDT1f
         VMlJINj81TPckhsZtCLNmChYUybAobdGalR0T4RXU4oYZh+9+MaSU1YhBrm4Ar5fsM8T
         BV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764301143; x=1764905943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXLSGxyqlw9PW9NDqgFwLCeID+cibWsbL+ACEydXwXc=;
        b=BTIXdIlHT9Kg0ZVaTxdq2q2rB9Xoa+tPp8ddsGuG2IDGTrlZtfFhfzx1AjyOV9C1p0
         J0XtsO55tiMYL7Gy8QG6e5KSfRgevCTd8ZAF5a4vTJQd5e9iQ6sXke5BTF0nXmHXykjI
         z6V8A72MEHj7U8WFWPkvv5kmjRg//b1zsHwJ7wT8p8d4QBpHFhPGe/Xd8HeEgh7itr3+
         dzPVLVy0DvI+eCUZn6nwKnFz3MlAmZuLwX7IlLGz5n8S8WMsMdi4Xwvki+eBppnmhXD7
         5yoKg/rGbmY54vsNfC0CCihFQVW64Txk4M5pYrASpdpKPehMV9i+6/tyqbCcgzvjuz8O
         gXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ry4vkfs4n4Zdg0lROymVI3TRM3QZtAHqfyI45Z2HMzVUzpNUN71s252GzaVVA8vnV0Bf4Q4Yn995lUSxWoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKINHXncIZN3wwpj4JEh5Nlr6WMrMqa1SP7wHrBP7fw0Y9fFum
	kOxLtqhmjcaUhn+uYlAyu0TyglDV1gASNAP6Xd33hU2dk1qJqXlrK012
X-Gm-Gg: ASbGncuSw41inT/JpZfm0BhFil0ibnUNPiADbrRFUHaHqlH12TIzPYQBrLrmzjsSwqn
	HmPOBf1wBn4O/9PoKqGlqDkD8Kpt5PoipWeWkoltgfntpCRfZgXoaGiCAg7NiGYiNYWlpsD3aDw
	A75cvqzGMp1RTQdGUXWE9gjyBB/MMUedrpA7IH6kSJjIYHKnDEyfpdNnG61uR/MtIxDQG244V7C
	dLSo0fSc9+cN+UEm1q4XVWB49+rj6iX8c5LXXT4VMV/X8n9gTpo5i7eUrvKVeT0o29Wf83qQpza
	aDJOsSKT5PvA5zHgD87xyRdOJ1ByTCtFDAdSUGnzmYWq7tbKfk811nCi7JjJYg4Y0Pl2rAydMzn
	qbeD1raQ84qpf7zWvBqOINOywHiYfpNyONx5o3eELCm+SSaiLhFo7lSZZqBz0t+o4x1PBjohN5K
	gGMi5kiZbqsDBE27DCSunsgpxGj6vUplEeugskHnnIkKg=
X-Google-Smtp-Source: AGHT+IE3ELtSLAn3cS8ZIIaoCXejMxDH6G7MwxZ/EqUfIf2ZaCbtg0fJtBdYds0m+odBYLXmysvpmA==
X-Received: by 2002:a05:7300:a2ca:b0:2a6:a306:efdb with SMTP id 5a478bee46e88-2a718576e14mr17180250eec.3.1764301142957;
        Thu, 27 Nov 2025 19:39:02 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03cc7dsm13999469c88.5.2025.11.27.19.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:39:02 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH 2/2] overflow: add size_shl() helper for saturated left shifts
Date: Fri, 28 Nov 2025 00:38:30 -0300
Message-ID: <20251128033830.331426-3-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>
References: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce size_shl() as a sibling to size_mul(), size_add() and size_sub()
for the left-shift case. It computes value << shift with both operands
promoted to size_t and uses check_shl_overflow() to detect invalid or
overflowing shifts, returning SIZE_MAX on failure.

No functional change for existing callers; this only adds a new helper.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 include/linux/overflow.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index ca8252e625d5..91d0b5b00a56 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -404,6 +404,25 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	return bytes;
 }
 
+/**
+ * size_shl() - Calculate size_t left shift with saturation at SIZE_MAX
+ * @value: value to be shifted
+ * @shift: how many bits left to shift
+ *
+ * Returns: calculate @value << @shift, both promoted to size_t, with any
+ * overflow or invalid shift causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_shl(size_t value, size_t shift)
+{
+	size_t out;
+
+	if (check_shl_overflow(value, shift, &out))
+		return SIZE_MAX;
+
+	return out;
+}
+
 /**
  * array_size() - Calculate size of 2-dimensional array.
  * @a: dimension one
-- 
2.43.0

