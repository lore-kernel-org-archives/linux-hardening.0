Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB209CA75
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 19:03:43 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED993B059A
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 12:03:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bfccec7f3so19656957b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322987; x=1695927787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEYxgEiQ2G0lBnnvjz69oKH6w7GyE7puCJV+/rYXSPI=;
        b=MgIiQmqYIo7Z9md3T5S49l7YjxfZej1O4gewC1oFHlETRv+NPfEojzTtHYG5auA58U
         BGSZSInjq+WXWoHNr7GXx3S7+0k//jxTSNSTarGOaEWV4QM0+E4iMgpBdDtySKs7/Rur
         BUVjrMmm4cU5Z7qButyE3TnduQLhzNFLmCk02wiJcHPYSHyQDxK2m76INj3QiQ9kZCio
         Eg0FvtNsOYTo7PK9/z0JmlAS7y7LFFlrgYgsAAE5hLHaACTC+KZ56ZopFk+QZ27cHdRo
         josdCRxls0SjcXlsdzhhqQ5reNpC20ibqvAtfTL5JiPT4pMeUtV1aaaC1GpOVVuqAGpN
         YEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322987; x=1695927787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEYxgEiQ2G0lBnnvjz69oKH6w7GyE7puCJV+/rYXSPI=;
        b=S+3zeR8SdNQoKcsByqNMpM/auL16NHga1T+gBJwI0qE+LmhizggdobnxcQOlSK10y8
         CZ0t6dcycfKs+lcMN9gLa6pwp96PMZ0Vwsdo6a15c5aY9zulVdTps5EWqs8dYRQ8X5Pm
         M5lk8/J3v6fIDIqkvFCJXUes6WBoIwY8a/mR89GWAWhe+a4hGuGHqxnWY45NEVov3t0n
         CuZbySlQzBa4Iz6U2aW0R0rAUJusoXQTO4dZ0m2zTmDxyS2d8nAuAa3T0PAhgXH4WNdX
         odeZ+eTUa1P08Q4gsy+d2xnyumjiwUp4JiEuA6sRMeDvaPT9Gd6zR92G16PPPhJqhazP
         ckbA==
X-Gm-Message-State: AOJu0YwxCx0IPs++ko/JL25fq29ziw3yFvOeyD0dvCqslt+gIJNHqjyC
	G+n8im+1/iSj1PqqL+/vkxjpzISCrN1m8bmMiQ==
X-Google-Smtp-Source: AGHT+IG9JP1J4pBm6vm4/7J90B3qLg30FrVskTwqtCiK09WfK3eRbjMqCD2nEv0oUdEhxfNK7H3bPH2RoaQFQ57HRQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ac1f:0:b0:d78:a78:6fc7 with SMTP
 id w31-20020a25ac1f000000b00d780a786fc7mr62541ybi.6.1695280667831; Thu, 21
 Sep 2023 00:17:47 -0700 (PDT)
Date: Thu, 21 Sep 2023 07:17:47 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABruC2UC/x3NQQrCMBBG4auUWTuQVFuoVxEXaTIx/2YME6lK6
 d0NLr/Nezs1MUij67CTyYaGp3b400CxBH0II3XT6MazW0bP7WUa65eTYRNrDM1QrEETlzeXDM+ xoHLkaV0kzG6SOV6o96pJxuf/ut2P4wcSjWpSewAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695280667; l=2643;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gl6rbcY5JocGZdujGLJVeAlqntg2FcLChTBuwnqHH7U=; b=NicE4L8AAk6eGWezYObrbvJqP3acl0HC36VETSmVRV4fbfv1RZmywz56MTfFRfbzVnUQx8JQ0
 ApR6UamY9EhBv4sAizOSMNlKCNEyUY1P3vMSPVFbgvy6kATdgL3JIiI
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-v1-1-37afcf4964d9@google.com>
Subject: [PATCH] IB/hfi1: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We see that `buf` is expected to be NUL-terminated based on it's use
within a trace event wherein `is_misc_err_name` and `is_various_name`
map to `is_name` through `is_table`:
| TRACE_EVENT(hfi1_interrupt,
| 	    TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_entry,
| 		     int src),
| 	    TP_ARGS(dd, is_entry, src),
| 	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
| 			     __array(char, buf, 64)
| 			     __field(int, src)
| 			     ),
| 	    TP_fast_assign(DD_DEV_ASSIGN(dd);
| 			   is_entry->is_name(__entry->buf, 64,
| 					     src - is_entry->start);
| 			   __entry->src = src;
| 			   ),
| 	    TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
| 		      __entry->src)
| );

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees NUL-termination on the destination buffer
while maintaining the NUL-padding behavior that strncpy provides.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/infiniband/hw/hfi1/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 0814291a0412..7b8e1456284f 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5334,7 +5334,7 @@ static const char * const cce_misc_names[] = {
 static char *is_misc_err_name(char *buf, size_t bsize, unsigned int source)
 {
 	if (source < ARRAY_SIZE(cce_misc_names))
-		strncpy(buf, cce_misc_names[source], bsize);
+		strscpy_pad(buf, cce_misc_names[source], bsize);
 	else
 		snprintf(buf, bsize, "Reserved%u",
 			 source + IS_GENERAL_ERR_START);
@@ -5374,7 +5374,7 @@ static const char * const various_names[] = {
 static char *is_various_name(char *buf, size_t bsize, unsigned int source)
 {
 	if (source < ARRAY_SIZE(various_names))
-		strncpy(buf, various_names[source], bsize);
+		strscpy_pad(buf, various_names[source], bsize);
 	else
 		snprintf(buf, bsize, "Reserved%u", source + IS_VARIOUS_START);
 	return buf;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-5b9ea605e6c4

Best regards,
--
Justin Stitt <justinstitt@google.com>

