Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46133F36D
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481527; cv=none; b=bC64bzs+EAelJ+x2uMvXsUgEDTYcwgGVR768iZrayECdzjemXN1gqrQFksxH6UTs96ltXBscgKfTIgNxmUT+GnGWe8nTBPk/1PXBhe7ucnJEjVjKR28iyO0rW7wknGhlzSzA4UebM0a27csL/Wv1cJ4P6TBSNSTwEPPF/bzlmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481527; c=relaxed/simple;
	bh=NqOoRdyRQwEnHaciOW1Lo15WOzVkPW8i+CqT++jomdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/b/WhUtwoymLTENkxssDDkgofVP5LSRAEIh7KbJyPe0fvsxQPCKFXdMdPDEMqVR1x65428Oz3RnD8hc9LsfYG6RCcHkUgsQoAzKSo6Jq3gHW+fJK75QAJA/+3xA/H8GpnIVqM0xvGYYlULS4XE/HZ/MJda16NulV560ysYy9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=c0GuwMPd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="c0GuwMPd"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84eb992a881so606274b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785481524; x=1786086324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXV9qH7UyhntE49tPsJBkiOVAaJG6JngpHeIAflWXR4=;
        b=c0GuwMPdOzqJUAGYdqnoaooYfpNFhiXhzAtOfICyJYNDQ0N9GjM/XAyjhTCF9HuiCe
         RYDC1I5LShs4tKGl9fMRjq0JQxROozcHjbT0gQKIi4GeHo1k7IT4N1Wif8CrzqmoaSgw
         lzf0KoAO3KpFlhOyK3gmptoTwOMyR7v2DOXyLS+tDG6KrUZLC86Kh4gry1FEq6gt4HKi
         qZi2cWJcgDtZVKDcueW91EWq8PYtjDkBoRYi8l+M4D0Sd0gODHh9UkGsGAhNBn9jtFpP
         Hgi8sgqDJpVT0Ms45t+OTAcI/RqVnZXZm30rfjIc+LeBPwUZrG/+nu2K5PMZOW5B7i2i
         TRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481524; x=1786086324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXV9qH7UyhntE49tPsJBkiOVAaJG6JngpHeIAflWXR4=;
        b=Ua7WIdzGDpMrNNutSV8A6YUIb9pbWUUvjShBFoxbybFY09zFngaHekJc8wieO5tX6Q
         o6SYFmNQgMtwEvBHEB7o0LIk/Uas+b/sWGopFQ05tD56IBkveYfpNgBsGkcyyPQYsAzs
         6VkKDUnS5YHB4LaZQaIfNjU80Z0lGkkLIhTxTeUdd9+P+zR4kNBG6kszMlTWHBnF+995
         21NIK3vQ+7asZ+c07XQpyntI4WB3DzqDYdWw/jAdJzE2QJ3FI1lyJQqPctR1OuP4FBtJ
         4h/C+Hj/7gjybPOX52gq68OpQNab92LpOGILPOek0xFLAX7+i0bOUd8wp1X8S0PUlKB2
         8T1w==
X-Forwarded-Encrypted: i=1; AHgh+RrQJcfvic43XaCrRuEOu9IFcAEyuB46Y+AWWwaNSGKM1U9haNhhUL/o3zE2uY6lo1FV0RKM1RytF1igIoWgfDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkYqhkJHBP0Y2iveNdJ6yPzrKVqgfudxusquHVH/JIRBdXI/T
	xNTnN9+tML3+QTeDDdquYvqN+7xcPjXl9WsFyt0W3CvvaEnCXXaFgbtG9kJnquDuuVU=
X-Gm-Gg: AR+sD110uS20CIgSOQU1M0jEYycWPAZpoDBKtmMpq2XOStQkWYzTW8fc2jMV1PgL8SO
	W8Kj1nm1p6hG/+QJ0qC8Q5DFEFv7qxAwigI56tmckFqRC+wjOi93ufRQPNg6UW1sv2o2xPH0RpQ
	gb+osiJJQV6VtvAsoVzBvNcIUZGIqJMPblXsZRlC66QK56aJ6cHbU2wpKzte7Ng7n+m+x/TTDI7
	PepJaadVYOuVInYXpraQ1IDo2iw3SdHjlDgGK6a85iIRpydlREJeyq5WfKEFghv2TetTHEgj98r
	LN76TQJ78DSNsskQBsxJ8fwLnrBFvyW3w5XpozXNcvonuLcLWr1IMrFAYteTxwDVlrzCn8wNXPU
	yEDdkZiTw1QioT03xDgeZQ3o9zU2fkaV/hUAEhhlDT7+FA2lj4bQ/rokIJAS7J6BiYcZ0chRSGv
	m1c1DCdr4DA2I1p4j01SQifUqm+xPAE5eMf3nU6Kr8dnUOeJvqUAVdNUkKHNCzuMf1hDTY
X-Received: by 2002:a05:6a00:3e1e:b0:848:5935:2e11 with SMTP id d2e1a72fcca58-84ed7266716mr671512b3a.48.1785481524374;
        Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm39233b3a.40.2026.07.31.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v4 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Fri, 31 Jul 2026 16:05:06 +0900
Message-ID: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split of the single v3 patch, in the order Jakub asked for:

  1/3 frees the LLC queue entry in smc_llc_srv_add_link() only after the
      last use of the pointer into it.
  2/3 bounds the peer-declared rkey counts in smc_llc_save_add_link_rkeys()
      and smc_llc_rmt_delete_rkey() by the buffer they read from.
  3/3 copies an oversized SMC-Rv2 LLC message into the queue entry and
      declares the rkeys that fit inline, so both consumers stop
      reconstructing the layout themselves.

1/3 and 2/3 are tagged for stable.  3/3 is not: it does not fix a crash on
its own, and it changes a structure layout and a static function signature.


---
v3: https://lore.kernel.org/all/20260727095833.1079618-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

 net/smc/smc_llc.c | 101 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

-- 
2.43.0

