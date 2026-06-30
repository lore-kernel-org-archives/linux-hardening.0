Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30473CF960
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852444; cv=none; b=DcQ1fBUfslLFYICgXEIO6JWtK/dfH31JT+h7Z41CH8kml9O5I1NVr4GXgiSbbwo+0/YbpFSrhrd4g4ScyQY3rVxDNupOQ4QMv50RmJaiusfwuBafw18+BFRZ/JpSr/ws/jiJPHPXWal89woldhhLy4csFmz5gwXD4vMVP5SAYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852444; c=relaxed/simple;
	bh=H6Nl1EagvECUztZYLhWf1birr8CMtAg/KVEJld06QVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agpCHtCQaBTHx818p/2NXKuSD/i4XkGpthBjcUl21+ZQMyPf1LZXjUupdsBOAQW3N/2iT4MeGK38OBbgkQyF49ionS//D+tnvitnthn4EzVfalkFrn026WwwycTpwXA/S4ZiZUVZKvu4FfyIsJ+cohyyXLSsRn1GW2JcA6wpbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdqJlU6w; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdqJlU6w"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8471013fac2so1585084b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852442; x=1783457242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSxXPen50jU9/mkf/L/2/YHLeSPCph0sWADACblHak=;
        b=kdqJlU6wG3dbSKnp7mTEh2Q/HJQ5nVATrXdwb/EGjzO/akiE3XiljJYh25I+CWkk5I
         1yKJX6E04GHJJAJwQPQIwQWrvFIrt6Hn81a5fi2L7+qdP3jIyLdzIYhZQtOjOpA4EW0A
         We1Skrk2Ek+ku5IaJTuE+XG/ghhFA2r1a03Wf1VYAxWQ9PWGibP9N0mwM0+TcxoEFLKG
         TFUmYbB8iNXK+ypGScPBQoow5rvftA/BmtwtjjQOmk318zhU02UQ7oLbKyvJ3dLPL5Hw
         HesQkSRlYwhBVCxI7SZjlpJ0hSIlj+f2wb+s2I88QLZZQ8RXm6H9kEd7TiqU58aUXyAR
         Uj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852442; x=1783457242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYSxXPen50jU9/mkf/L/2/YHLeSPCph0sWADACblHak=;
        b=aZFLVxQgkmrsmNyFxTQLjphfLpDrkZqzIL2UkE7531aXBojvozQqLY1wAHtUSy8kS9
         XqbsSvqsTjxIenxBbaid9tIr0V56MkWB4mSCNGILhxZm9JH/TY9WxueT7n8cCnBe713e
         4mmc5wKvvONZezhoG5uIhggtgiB/XlfOYcR/XAcsdKwY28N8U9i+C377DvunguCH3cNz
         KcRx4l7o6ssKL4Dra5Z0twbTwX89G7tW+gHWelSr4YsRviw4Q5KygBJKnjZVrvdZhce8
         aOefa3pUAeCBxc308gPD3NN3tCu2/snLGd3HMxldvB9VFNs+HhJyGL8wn1F4qcMY71n/
         YvIA==
X-Forwarded-Encrypted: i=1; AFNElJ/ljbHjaPaAIzzCUw7aIHcN8EtjOVdOhKu5LtSWJ995cGHWn7QtsOu6V1WjMGCu0QuBRkf0BbMrJZ04dwROihU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEysuxe9aIuwURQtEglXfgg8XLd0VPjf2+TvfuLWEzTwUM03ob
	9yt/UrSHxCulhusbzNEas/FY9k95Wm67IhISI9nALty/vrm3PJbfZDkp
X-Gm-Gg: AfdE7clZtjm8ipFpRml1Wzhgr7zBJyKl5JLT/mirGYRZ6XeBKZAFpxPzzn7wuro2L/J
	ksDcuUXcxx45cepMb6ZX9u56fp0l/CFpZppAwC8Kg1dmLlwRKDyYCazcIQ+VV/uXmDA2HCc4fPY
	1GBecfthjyXFkJ45ocIQ2zh4Su1nyn+dERgUyXfpkFm8p4vqnvZZbPf1UHsC/kbd5j+WXmFLK9/
	GtR3YMgLl/KINX2LoaUu20VSTorHs0NIcO4Y9v4nqh1OKVr5kWyjvFumIC+mKCRlv/EH0JnvPn3
	ywnlQI+CBxEgxULjVdmHE+P2ZXMFbFmJ3/uyefPJHIpKLgW+9jO5gfcLasCbTXl8pCSZeiIKuOS
	LutQSCvJzbfzJuIXYrCFlZNFmo4HvRgyTA+SrXyIjV4yLi4Dr0I0lXMXzCS1owl0inWXBAGazQL
	d3SgbNN8xlaSPshKsVPTlcUjmOjDFjBhENaUb9Ph5+GH3T0INkzmDPaHlOEfJ87BEjcOKa2TVxM
	3ooUxcIjQ==
X-Received: by 2002:a05:6a00:a24e:b0:845:344f:ef1a with SMTP id d2e1a72fcca58-8479eec64e1mr4599716b3a.15.1782852441908;
        Tue, 30 Jun 2026 13:47:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8b454sm2773464b3a.10.2026.06.30.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:47:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SC...),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] firmware: arm_scmi: simplify some allocations
Date: Tue, 30 Jun 2026 13:47:19 -0700
Message-ID: <20260630204719.334211-1-rosenp@gmail.com>
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

