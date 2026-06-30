Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279F33BBA7
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782473; cv=none; b=nBpMw95XW3wpg09c6bTuIEvTUtT13gZBQV2yAFzzaayJ5y1CyWTWio0sXfo1vrw6K13aWzwVPjaFEncYrbqYNDCWD3LOkaoPyq56n5jU9i1yBS2wis0vn0WyEoyamRbQdw5M3l0fATYRm4+e1YnIcdm8K41QnFJ/5J+3LVYIHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782473; c=relaxed/simple;
	bh=NcHqpszERXjT6L6QRCE5wtLwJT4Wa3f3AWZ6iw/lRs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJsK/7kmbIhqOkfU3GW/F+HhoWE4sAR4eaAUGx6trc/0pZEri6uLTZQozBlP8vW8UgCHG3XQH94GjntlTNNthjEqXkMbnZKSXQm4Q+DYcc0l+gkPJPVvOOIkOMknphp2+ktnYXO38rZ1eBJLCFqb7lDDlURnEL1Scmc8XoPvRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knBvwv6t; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knBvwv6t"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so626392a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782782463; x=1783387263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLMD0egzUCNwTlRP4H9rot2jquTKrKUwDtaYpTqbx2Q=;
        b=knBvwv6t6gpDSIkRVagkBaMb4sL127quTTaNfXA9w/KDSYq1Sy3vSDVn9ah8lD+d7G
         hwuk+DEaokclsExt3veXJEBNxfxxXhXzg7QqN8qr4S3esXWHRjwO8QKDtwl6/7ML6Lbu
         9YGupVnnTU0dUnM7ZxSszPDCvNh3yDV60AYDZcQlOv1xHJzFcj33CoKvH7fMNMLYCbkF
         9GV4co6il5n+8ZZ+8tFprnOUCxFRH6O5MTTXZdECLVewiTec2MtPdlETiWB05dtyOaZf
         bpW3YHAw3T871Qw9EyPaHovXwP9ZCZZ7gIofcUktvobpbRPPV40myf/HiVj5S7vAOHu4
         QRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782782463; x=1783387263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLMD0egzUCNwTlRP4H9rot2jquTKrKUwDtaYpTqbx2Q=;
        b=ITj+/ZzK6TwU06KhxGr1LnndFv0CUSlMnQc5DaEz0aoSp5dnLGbUcXe2w79ynJ2QqH
         ZTF4T2wqrVqsuw0XHMHWdrrmQnXjA6pZS6plfqXErztAvSOJcOnNCAqh+n2GHg6JF3Nv
         mkl7Nh18AzWHOzObtNagOxVZROxfp+esHV+N8W+iY/xVmrEsc/euE+Gf92cg+KbWjaxZ
         DFJhU09EBO2LOkqjxhHGzn3QXpoj57ATLQbyQa2grc00E67ehFo7EILl5CvwVb3A1IIh
         iMKjq1qA0YHwOQ1JSSKqW7UkW89S5ExK0rVw50UBEu3SuTn6DvxGERxhfwZJznPWT3E5
         H34g==
X-Forwarded-Encrypted: i=1; AHgh+Rqwa4gNjMBFjD6vLH00Hy3UV3lV8CtV0IPl2VsqqiEMpUIZNT1cdW2b0VeybqLpq8CBxS8wZqS+ngUr7qJJV4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwC3u+00EnDRgH1oLSaiqEiCewM2oiBV9ccjaQ1xUE+nBSpXJ
	Ym5TQXdbd7BnbfajV4cJK3Fu0egTecrApjvBdZ+giCsVvE/Z/WiBMLVL
X-Gm-Gg: AfdE7cljWEipBM2L1SI1yHF1FgwIUlZvv2hVHomHhjg/hBAchgO2alvyAPAXgMFb40N
	LGe2FI/zGplIpWLYoEXa1r/A60rA6yFigy2UxvcblQSjsAuqjNIC2SZWGB29xMBT5+sXI7WNHb8
	S9RPv5J+haP8fIcMnWXs2FsuYW26H6eOUk8G+qaZWFft5p5OkUmYLlruHjJrBLep5YbPN9Myx9g
	6U29ou7ulADoxWu2peYAl+j/iklHHXUV3qcMbznB5KqEyyhcSwacdbSxRswDg/FclqnliR0IM4W
	A9al2v7bUAmR12gbABNns4HljxK4PushaddbZR/1SpONUlj7CEdjV9kkS4xfpGmIkDk3UbwvIPx
	/Yksz5WjKvm7GUJXjRpmBazUCx/WFZN/cM4xunpHRLWRdn4gC/jmOrXwtwqBVK6uWUvLKiszNzq
	E8Grq3JJG3o2j8V7Dsgz7Q2K2opFlI7Oj37itQS9uK+9y11qkaPNTEHIn26Fua1HXEPkQw9gIO8
	06+UJ/vSQ==
X-Received: by 2002:a05:6a00:ad89:b0:847:9aa8:d3bb with SMTP id d2e1a72fcca58-8479eed1d30mr1294340b3a.12.1782782463469;
        Mon, 29 Jun 2026 18:21:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8c7b5sm689184b3a.11.2026.06.29.18.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:21:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] scsi: st: use kzalloc_array
Date: Mon, 29 Jun 2026 18:21:01 -0700
Message-ID: <20260630012101.1461335-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/scsi/st.c | 12 +++---------
 drivers/scsi/st.h |  3 ++-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index f1c3c4946637..31ae189b18e7 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -149,7 +149,7 @@ static struct st_dev_parm {
    mode counts */
 static const char *st_formats[] = {
 	"",  "r", "k", "s", "l", "t", "o", "u",
-	"m", "v", "p", "x", "a", "y", "q", "z"}; 
+	"m", "v", "p", "x", "a", "y", "q", "z"};
 
 /* The default definitions have been moved to st_options.h */
 
@@ -3973,21 +3973,15 @@ static struct st_buffer *new_tape_buffer(int max_sg)
 {
 	struct st_buffer *tb;
 
-	tb = kzalloc_obj(struct st_buffer);
+	tb = kzalloc_flex(*tb, reserved_pages, max_sg);
 	if (!tb) {
 		printk(KERN_NOTICE "st: Can't allocate new tape buffer.\n");
 		return NULL;
 	}
-	tb->frp_segs = 0;
 	tb->use_sg = max_sg;
+	tb->frp_segs = 0;
 	tb->buffer_size = 0;
 
-	tb->reserved_pages = kzalloc_objs(struct page *, max_sg);
-	if (!tb->reserved_pages) {
-		kfree(tb);
-		return NULL;
-	}
-
 	return tb;
 }
 
diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
index 0d7c4b8c2c8a..759f4c43d563 100644
--- a/drivers/scsi/st.h
+++ b/drivers/scsi/st.h
@@ -45,7 +45,6 @@ struct st_buffer {
 	int syscall_result;
 	struct st_request *last_SRpnt;
 	struct st_cmdstatus cmdstat;
-	struct page **reserved_pages;
 	int reserved_page_order;
 	struct page **mapped_pages;
 	struct rq_map_data map_data;
@@ -53,6 +52,8 @@ struct st_buffer {
 	unsigned short use_sg;	/* zero or max number of s/g segments for this adapter */
 	unsigned short sg_segs;		/* number of segments in s/g list */
 	unsigned short frp_segs;	/* number of buffer segments */
+
+	struct page *reserved_pages[] __counted_by(use_sg);
 };
 
 /* The tape mode definition */
-- 
2.54.0

