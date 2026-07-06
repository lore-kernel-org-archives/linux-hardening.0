Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D64F3D34AB
	for <linux-hardening@vger.kernel.org>; Mon,  6 Jul 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380635; cv=none; b=SQa3N/xlQggHp8itxYII0wTJmEexNweKaAADE07k+BxZAX870NdifIJTzbbKRn2A0O/ojA4JFc0oS7WPc//0LuhErQe7jyiSOrYP+fFaNztJBDMwhOudFtVvk+ZwCzGnL384yLgYpqqVeyWwTKPG6GwfOd3nkvam2EqH2UMeAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380635; c=relaxed/simple;
	bh=SLW8WrLBlFCgWLBf7dnpDb/jTAtbAWktNj6RWs4dTvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2az6ouF93XiQAwEJX5/PomH5h/22HNfLPU7qNxhC7nEyZOP2iiT+xvOHmyr4+K1L/NqBmRWhjs5lWmQYFxJVC4L1IBlkPUGcsJbB4K5ImtG/+9sev7aow016oejhg6I6zPX5ccXxk7YN0p2dh5CSOUathQl1fcj2YdXoS18YL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T989Z/6E; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T989Z/6E"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efef6533aaso27427426d6.0
        for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783380633; x=1783985433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBr+hnnFmHItjtpfNGkl7u5UUjWMDOi9fk/G15N4o2Y=;
        b=T989Z/6Ej/mppJX/sweFwrtgfsA5QzAUvGu+CIlzmRm3ycajwMsXC00I26pgbe4Ntf
         /9PJfzuLjspjbeiendXaIkgGv0RFBARgrmK8d94gKqMddVSzsU2WZeDQKT0BOGPXfdRi
         x4BG8TREtvv/7NUUtHqpD6BP3HLEsJX2FMhvntrdw77Bznx1XZvGeGGoQAgE8DSXNMiR
         LRdeWcbOOkYluHXqRTNDP5H+00FI+TVx0NIgQE+/efcfk+rid0aHL3WXvTirpdRZuUTA
         /qheak8owHgTAI6WSO7FOKyfvosKUgRGxJXam9CxrGFlnuUbrddJCbNV/mTF3sTdywzD
         +d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783380633; x=1783985433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBr+hnnFmHItjtpfNGkl7u5UUjWMDOi9fk/G15N4o2Y=;
        b=pCP0fUyKEqbi8BNE+ka3fW/ubFXkHtRM1SsJM7l1YWjll/qJziU7hXY4lkKnSI64oO
         /5zrYy9m+qj2cNq7DNUJug21P/DrzXcQXmOgCfKaGl43zpjs25zWK9RVuXe4uaAU6zEb
         hH5oYZAw9RLiVjtAOIURGauw4QO2J07mLnpbYOjsCq/uzII7wD4vbbq6EDvt1OJ+qdYp
         B4MBA8L4pyDD8/E/4ebXQtee06+lvvrsZuYx3ms2sb9OEHIFUXy7GAZnyZPROoCu3BW4
         1sVK+ydrNQWAkhCDOEDxeZKbR7Jk8P2MEf/8Hgh9sDG2Kwk8nEgnj+K1bEWKjHBVfIjr
         FDmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBRpE9QcOkOYqolwnjKhSEn3RYRG8ywlxPwOzf2kbJ3S3eVhd+Sv1UTTZOQqXJ1ebktOC75ZWLBScs5bpOWLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9Y+6MkCxRricJwNiO2i4CGzyevbRN8SiDV9sGd4IftaFqLqK
	OsiY8CroC58jtEEhovZQPZ6Xx1c541LyIyzusyNusu9jLFJIG41TS2gS
X-Gm-Gg: AfdE7cnF3UM+Q8HnBmJvjStrDDKl/E5pxQezTonrSWgObOIW2LQR+XCTMcfJhDnkmTE
	p69CySfF8wIQkKLKiqONzkrvYL38Y5LuHolq2m82GLxxHvguwSr3NXhl4D5UU4RbOktAukVQz2y
	IYiIREy3wXpfC40OCP0lw1BHCAqkncGTrGdWSmIcYify0acnQH9fQMAki1wN9B4sHsMZF8ctpgJ
	WPynaK0+mvUPRwk+pAzSR9T9tAVuLozLsMUGhXAG4LUIHGBTHis+HES5/xIwj0KN8ACoxyDJsp2
	qJyH8cpZrHlhQmhE1yV9vZrBfKWloiYwoppFTdsZGAmUrWNjTVw9G1bnURYTK440oO3iT0FaiCr
	zSI4XpeuMcqb3i0/fFyJBB0AEfAmd5qAwUqb4nm3eigf5u0P1TPfK5jkqrRwf91nbp32kbSaS8q
	0L/yBle07Xy6AEgH4h+F+VidJ2EduGNPY40SYDs/PgRfnXjp1BBQZV6/iTvZdEVgrasyC8cQIZ4
	Mtdo0mtVs7aFd76Rxgz
X-Received: by 2002:a05:6214:202b:b0:8f2:8fe9:752e with SMTP id 6a1803df08f44-8fcb4fe943dmr37631566d6.53.1783380632620;
        Mon, 06 Jul 2026 16:30:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e371bdfsm146137956d6.1.2026.07.06.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 16:30:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3] scsi: st: use kzalloc_array()
Date: Mon,  6 Jul 2026 16:30:29 -0700
Message-ID: <20260706233029.814601-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge allocations to simplify memory management with kzalloc_array(). No
need to kfree separately.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after allocation as kzalloc_flex() does this with newer
compilers.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: typo fix
 v2: remove the kfree and add a description.
 drivers/scsi/st.c | 13 +++----------
 drivers/scsi/st.h |  3 ++-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index f1c3c4946637..55238f23f743 100644
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
 
@@ -4533,7 +4527,6 @@ static void scsi_tape_release(struct kref *kref)
 
 	if (tpnt->buffer) {
 		normalize_buffer(tpnt->buffer);
-		kfree(tpnt->buffer->reserved_pages);
 		kfree(tpnt->buffer);
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
2.55.0

