Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67731392C28
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852713; cv=none; b=Ginkdo1+1SuVPk8CA+9ENOrQzqxpCJeYzrGn8CPtkgEqrWOEvM5szguEcZ5Ii3JrbKwYa9yWBK5Dd48lt2yE+y/6WpDJDL4x2NGd6ggXwLdzVsVtWoTcWWFXcQdr3UrO4MI+tajpIoGwZ2b12vQqmOehmjkzO9m1SvugSHkrFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852713; c=relaxed/simple;
	bh=H6Nl1EagvECUztZYLhWf1birr8CMtAg/KVEJld06QVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM4/wXtkESDJ/CX9pwuTmAtXSieD5Kj/O4LVj2fCUvX9vJQMi/oQQqvWzvsoa4e1X+JbgbAaTCGr/Vs9nYDft9d6tffPLNIjQ5YQp9SB4Bv24zH8EYKe7m7J+lVHuA6yCrDHYAwAPSoeTO1u+yQ2m0tjH/hNrd+UpT/BgxHFrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltd9SfCw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltd9SfCw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso1428569a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852712; x=1783457512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSxXPen50jU9/mkf/L/2/YHLeSPCph0sWADACblHak=;
        b=Ltd9SfCwla8wnZ/aW2sJqbkIBJGPoXcLqN/32tC67k0Xz6tUj9qraMvFpbat1xg0rF
         iA1wMGEQqwAOhX1V3+Hm4hRE6NENlmm8NCEPXSodieRJFY6Jf946lLcKIVNRWLZ5V1St
         3BCVWIfhgBVNGsKl3FA20tFTG2srTlbtcXLRp4K0B+QTSB+tCBVgGEPXdiRWXP+VsVyO
         TKsxSll4wvFMRvBuGXp8qbWIZ/wKSkYF6oiauImAaDbHWYIvDMIB3aEQv+OETtJTWNCu
         EUWe7Q5aVV4fGiJFV3dJrJX8C3DKCwIrXfRU7BWPUkvBBRpcZ1HDgWmm6SXr7HDpuJVe
         juRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852712; x=1783457512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYSxXPen50jU9/mkf/L/2/YHLeSPCph0sWADACblHak=;
        b=FUR9NWynCkH0I3YnY8y6hVr2L02i/phPW9FD32ilO8vyweSdd8joep44BvssImkTiZ
         u1H9KUJpQ/nENZaTmQvpDFLUl4Fbp20kIgPuL6IKTZoh5CvQ1lIbcQkMVxiATXQ6ggBR
         UDDeicqSamI1c84BMiVZjWne2pKq/NF0ybXSD9hJ92ay508fdHBfXWXkr2NQCq/3IOCL
         5BqC0ykTimrW/jemNxsTYGzBfFNgpm5aTlQMvSMUm4+XC3fUJ2Vbqxj/bBxlYXA2d5Hu
         ut5TWVIMwoKZZp/z/kljyE0eTvla+kMdigxRWGmM7X/u7P42SVanPEUB/JpcPPrgAYva
         ZCow==
X-Forwarded-Encrypted: i=1; AHgh+RqI9Ut342SwCZx09ZdTsB+XmAqUB2U0nybSDFCTQemBnRyxIeW9rXVAQl4w1nYWh9u4eiqD/E94WWTTcCUXiAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pRuzf36JpjXXK1adtegYGpnCBKKbVGUajJgpLFK5HYFhZfR+
	Y+C18PZmAl3MpdSJ5YZRq1oY1ovJ8dWCQB7CMBkv4sYSVuNKk7WH66W3
X-Gm-Gg: AfdE7cnjv4k1+Q+h1gdyN0PbMzrZ3kXrPb/xEKaIeuWpfXI6lwjWAxUrT2tItfXvVPP
	7QT0cEy9SlBNklfcgDDDfJOtiSPVbWj0aGpjshC2UBbzoQM5Z7mv64ZrXrJlnnC17wVLUyvEoPw
	EaeQzYnUdgVJ5tNb2jPmVV6v+MEHQ72hS0y7hp0iRJZ51UQk9JEUQ7qjpHHi67Hav/SQJ/fizUA
	OefP0qZH2qhx/k7DqUqPT/URr0ZmKk81btrJJd9oXZugU7YgC7H6MJ9Ol86fQTLvKw3yQxEjmX6
	jK9k9CmH/weOUY6jsAUZG3TjqXSXozkXD4RLkof3NI3k8fk3qUphQEy4ZiibjZ1lYu4lPfpjsEa
	Y7hIXbEDF8jjeam6gRg2UrWMbpCQvaE3QpkbMyQyno91A+L8Yz1OfJE8y4ES5aiIGX/+4Kcz1Z6
	/gnKQYnima4H1m4eP3AvREjAHfX3JLgEgg+VETAeLu7Q9KUE2ZVeb+Rw4JeW7wc8yJ063XVL2Mo
	khY2B7tZA==
X-Received: by 2002:a17:90b:4fc3:b0:366:52fe:e749 with SMTP id 98e67ed59e1d1-38052538759mr4416067a91.5.1782852711641;
        Tue, 30 Jun 2026 13:51:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38096ba2a98sm441541a91.8.2026.06.30.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:51:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SC...)),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] firmware: arm_scmi: simplify some allocations
Date: Tue, 30 Jun 2026 13:51:49 -0700
Message-ID: <20260630205149.356798-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use flexible array members to combine allocations and remove kcalloc
usage.

Add __counted_by where appropriate for extra runtime analysis. Move
counting variable assignment after allocation before any potential array
access.

Also make registered_protocols a static array. No need to use
struct_size when the value is a constant.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix missing struct_size.
 drivers/firmware/arm_scmi/notify.c | 42 ++++++++++++------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 40ec184eedae..8f69f2f599b2 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -209,11 +209,11 @@ struct scmi_registered_events_desc;
  * @init_work: A work item to perform final initializations of pending handlers
  * @notify_wq: A reference to the allocated Kernel cmwq
  * @pending_mtx: A mutex to protect @pending_events_handlers
+ * @pending_events_handlers: An hashtable containing all pending events'
+ *			     handlers descriptors
  * @registered_protocols: A statically allocated array containing pointers to
  *			  all the registered protocol-level specific information
  *			  related to events' handling
- * @pending_events_handlers: An hashtable containing all pending events'
- *			     handlers descriptors
  *
  * Each platform instance, represented by a handle, has its own instance of
  * the notification subsystem represented by this structure.
@@ -225,8 +225,8 @@ struct scmi_notify_instance {
 	struct workqueue_struct	*notify_wq;
 	/* lock to protect pending_events_handlers */
 	struct mutex		pending_mtx;
-	struct scmi_registered_events_desc	**registered_protocols;
 	DECLARE_HASHTABLE(pending_events_handlers, SCMI_PENDING_HASH_SZ);
+	struct scmi_registered_events_desc	*registered_protocols[SCMI_MAX_PROTO];
 };

 /**
@@ -276,13 +276,13 @@ struct scmi_registered_event;
  * @eh_sz: Size of the pre-allocated buffer @eh
  * @in_flight: A reference to an in flight &struct scmi_registered_event
  * @num_events: Number of events in @registered_events
- * @registered_events: A dynamically allocated array holding all the registered
- *		       events' descriptors, whose fixed-size is determined at
- *		       compile time.
  * @registered_mtx: A mutex to protect @registered_events_handlers
  * @ph: SCMI protocol handle reference
  * @registered_events_handlers: An hashtable containing all events' handlers
  *				descriptors registered for this protocol
+ * @registered_events: A dynamically allocated array holding all the registered
+ *		       events' descriptors, whose fixed-size is determined at
+ *		       compile time.
  *
  * All protocols that register at least one event have their protocol-specific
  * information stored here, together with the embedded allocated events_queue.
@@ -302,11 +302,11 @@ struct scmi_registered_events_desc {
 	size_t				eh_sz;
 	void				*in_flight;
 	int				num_events;
-	struct scmi_registered_event	**registered_events;
 	/* mutex to protect registered_events_handlers */
 	struct mutex			registered_mtx;
 	const struct scmi_protocol_handle	*ph;
 	DECLARE_HASHTABLE(registered_events_handlers, SCMI_REGISTERED_HASH_SZ);
+	struct scmi_registered_event	*registered_events[] __counted_by(num_events);
 };

 /**
@@ -338,9 +338,9 @@ struct scmi_registered_event {
 	void		*report;
 	u32		num_sources;
 	bool		not_supported_by_platform;
-	refcount_t	*sources;
 	/* locking to serialize the access to sources */
 	struct mutex	sources_mtx;
+	refcount_t	sources[] __counted_by(num_sources);
 };

 /**
@@ -706,9 +706,12 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
 	if (WARN_ON(ni->registered_protocols[proto_id]))
 		return ERR_PTR(-EINVAL);

-	pd = devm_kzalloc(ni->handle->dev, sizeof(*pd), GFP_KERNEL);
+	pd = devm_kzalloc(ni->handle->dev, struct_size(pd, registered_events, num_events),
+			GFP_KERNEL);
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
+
+	pd->num_events = num_events;
 	pd->id = proto_id;
 	pd->ops = ops;
 	pd->ni = ni;
@@ -722,12 +725,6 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
 		return ERR_PTR(-ENOMEM);
 	pd->eh_sz = eh_sz;

-	pd->registered_events = devm_kcalloc(ni->handle->dev, num_events,
-					     sizeof(char *), GFP_KERNEL);
-	if (!pd->registered_events)
-		return ERR_PTR(-ENOMEM);
-	pd->num_events = num_events;
-
 	/* Initialize per protocol handlers table */
 	mutex_init(&pd->registered_mtx);
 	hash_init(pd->registered_events_handlers);
@@ -796,18 +793,16 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 		int id;
 		struct scmi_registered_event *r_evt;

-		r_evt = devm_kzalloc(ni->handle->dev, sizeof(*r_evt),
+		r_evt = devm_kzalloc(ni->handle->dev,
+				     struct_size(r_evt, sources, num_sources),
 				     GFP_KERNEL);
 		if (!r_evt)
 			return -ENOMEM;
+
+		r_evt->num_sources = num_sources;
 		r_evt->proto = pd;
 		r_evt->evt = evt;

-		r_evt->sources = devm_kcalloc(ni->handle->dev, num_sources,
-					      sizeof(refcount_t), GFP_KERNEL);
-		if (!r_evt->sources)
-			return -ENOMEM;
-		r_evt->num_sources = num_sources;
 		mutex_init(&r_evt->sources_mtx);

 		r_evt->report = devm_kzalloc(ni->handle->dev,
@@ -1673,11 +1668,6 @@ int scmi_notification_init(struct scmi_handle *handle)
 	ni->gid = gid;
 	ni->handle = handle;

-	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
-						sizeof(char *), GFP_KERNEL);
-	if (!ni->registered_protocols)
-		goto err;
-
 	ni->notify_wq = alloc_workqueue(dev_name(handle->dev),
 					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
 					0);
--
2.55.0

