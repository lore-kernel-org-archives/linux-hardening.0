Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005860;
	b=X3jkP8f0js3/0iYc1Itpx1FDTenz/IuGcHvRZ7d2TLtOan4fV3g2vL2vi4yKvEJOsLtE
	 ie6DSE3EsUpqSNZgcqkX64Me4BIGzG21D1wm70aX5jSc1qstAvOC1PhXAAqzfjYYRnxL/
	 lz9Qoppjt5EeEqECUaPsnM6xICEUU8Tx4ANHk9V8c1KG7q8eJkFEO9YDGVdiVY45bS9kx
	 nDu6SriwKpIZEEsAwNMwYYuuQQdJkdCEJvO/dJzrXEkDd3zUELXX9z3GWv7cJZuZiXs7X
	 kl4dqeEPcQs6Uf3Ki2tKj1M3k/955xBUSdRJeF4NI+HD4BQ30rCozEQR2zMAkjz95qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005860;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qpk9XEKvThcdJFjlz5LJdwaViNuq34svrbiJiMCaHM8=;
	b=SXb6FrsjNcxzJKoXJM6y318nhlFO2SvA1gKPgTeIr0/ibiWyWzzzx66f6Hhw/AAzV4gc
	 y8inOd6PAps2vTp1NzTrZz9Jzf+pftOEQTFbkHxF5JW8tWUECALyC/p/HWmEGRVb+QgrM
	 PneBdSZHvDG+BYAgzmC4+6iNpGhU21tQYHE+oQQewh+CdVLLyLtad/Op/trBEOm+8Bja6
	 lHEIDFQf+YUSu77KBAUazkuBM17W6aSM6l+m2s5VfpjzeBvAmXnr8T9L9YnHlR7TgDkhK
	 EiPdczwMbRm/iVTXaUWo820CYOqfDOiHnWdBwn62TgaHde8or0BPsQtjLaaDFkaujfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhQ0yZfa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FD60A260A;
	Wed, 18 Nov 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhQ0yZfa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB421F000C5;
	Wed, 18 Nov 2026 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005860;
	bh=qpk9XEKvThcdJFjlz5LJdwaViNuq34svrbiJiMCaHM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XhQ0yZfayEkTaaREtrrwfOhDzFl4Q2dtDAWZkQ1Kg7saH3O933WJF1v6mhf44FGQW
	 +y79KLdfH7VSLaigXRF1kfedTuUCnifTJ/lh/+RLh25wfRW2xeQlfry8UF8DZi9yjx
	 WUrfeI8AHbWl9BQe2IqO8gQB+xq4F8tuuS3Bwy45nvWmBAdGgdFux8wOIaq0+pIcM3
	 01ZhfkYxFO5MHBWAZ6CTumrN4Fq1RoOroJESWJS2lXu4uYV0LnxjxluLhF5Z5KzuXJ
	 MG0v/3aOJKJq6PhcQEUsxow0s7P+OcrrXSphgaA0xwsy64Gi0oz3kPpsqkm/jRMk6e
	 /TxsnLshkOA8g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:53 +0100
Subject: [PATCH RFC v2 09/16] Documentation: media: Add Media controller
 event documentation
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-v4l2-sensor-detect-v2-9-1bb1a445b556@kernel.org>
References: <20261118-v4l2-sensor-detect-v2-0-1bb1a445b556@kernel.org>
In-Reply-To: <20261118-v4l2-sensor-detect-v2-0-1bb1a445b556@kernel.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andy Walls <awalls@md.metrocast.net>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nicolas Dufresne <nicolas.dufres@collabora.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8696;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=iMwjFIn5BNb1TUM8DMHBaUPcXBV1TZU5XSRmhTpL5Ds=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2LJg6tfB+S2JCW9A6QyThinnlVoRxi6Oht8
 +Jqjc/6q3WJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2diwAKCRAZDR20Zk4Z
 NYwLB/9SgAyTu/4OOfU9ymrRJCbvlw4shRmus0qIms5wLWsy9IYQTRgxKkojmUpOX/H/d+9FfiN
 EzmnvVEKl2y1GCiDkTfV3x15NOghPvnaEriF7WNKNysMmfyrJlj5Dhgvk5saDJg8nTIw2MVEd3J
 4wnE0b1Per0eeyINDMcmqqqKLNZCXHJTn7wcHTebj4FXcacPpMzaJNYKiOz3WLdR6rfYAoyCH2t
 EVvWZSS2t6LmJNMhczcGHTE2zJ+BwRDz2q6tVlfi8fVtF/JZoSdHAEjPRakBHJ4VK0xhGQphOvI
 qpqQPvjENz1q0JJh+L+Bvw6OhFaX0e0VJW4WU5EeQITskyqi
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Add documentation for the Media controller event IOCTLs as well as an
event, MEDIA_EVENT_ENTITY_REGISTRATION.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../userspace-api/media/mediactl/media-funcs.rst   |   2 +
 .../media/mediactl/media-ioc-dqevent.rst           | 125 +++++++++++++++++++++
 .../media/mediactl/media-ioc-subscribe-event.rst   | 112 ++++++++++++++++++
 3 files changed, 239 insertions(+)

diff --git a/Documentation/userspace-api/media/mediactl/media-funcs.rst b/Documentation/userspace-api/media/mediactl/media-funcs.rst
index e896296812c1..a9ce38b7144f 100644
--- a/Documentation/userspace-api/media/mediactl/media-funcs.rst
+++ b/Documentation/userspace-api/media/mediactl/media-funcs.rst
@@ -19,6 +19,8 @@ Function Reference
     media-ioc-enum-links
     media-ioc-setup-link
     media-ioc-request-alloc
+    media-ioc-subscribe-event
+    media-ioc-dqevent
     request-func-close
     request-func-ioctl
     request-func-poll
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst b/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst
new file mode 100644
index 000000000000..f7a2cd2675f5
--- /dev/null
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+.. c:namespace:: MC
+
+.. _media_ioc_dqevent:
+
+***********************
+ioctl MEDIA_IOC_DQEVENT
+***********************
+
+Name
+====
+
+MEDIA_IOC_DQEVENT - Dequeue a Media controller event
+
+
+Synopsis
+========
+
+.. c:function:: int ioctl( int fd, MEDIA_IOC_DQEVENT, struct media_event *argp )
+    :name: MEDIA_IOC_DQEVENT
+
+
+Arguments
+=========
+
+``fd``
+    File descriptor returned by :ref:`open() <media-func-open>`.
+
+``argp``
+    Pointer to struct :c:type:`media_event`.
+
+
+Description
+===========
+
+The MEDIA_IOC_DQEVENT IOCTL may be used to dequeue Media controller events from
+the file handle. The :ref:`MEDIA_IOC_SUBSCRIBE_EVENT` IOCTL can be used to
+subscribe the events.
+
+.. tabularcolumns:: |p{4.6cm}|p{4.4cm}|p{8.7cm}|
+
+.. c:type:: media_event
+
+.. flat-table:: struct media_event
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2 2
+
+    * - __u32
+      - ``type``
+      -
+      - Type of the event, see :ref:`media-event-type`.
+    * - union
+      - ``u``
+      -
+      -
+    * -
+      - struct :c:type:`media_event_entity_reg`
+      -	``entity_reg``
+      - Event data for event ``MEDIA_EVENT_ENTITY_REGISTRATION``.
+    * -
+      - __u8
+      - ``data``\ [64]
+      - Event data. Defined by the event type. The union should be used to
+	define easily accessible type for events.
+    * - __u32
+      - ``reserved``\ [8]
+      -
+      - Reserved for future extensions. Drivers and applications must set
+	the array to zero.
+    * - __u32
+      - ``pending``
+      -
+      - The number of pending events excluding this one.
+    * - __u32
+      - ``sequence``
+      -
+      - Event sequence number. The sequence number is incremented for
+	every subscribed event that takes place. If sequence numbers are
+	not contiguous it means that events have been lost.
+    * - __u64
+      - ``timestamp``
+      -
+      -	Event timestamp. The timestamp has been taken from the
+	``CLOCK_MONOTONIC`` clock.
+    * - __u32
+      - ``id``
+      -
+      - The ID associated with the event source. If the event does not
+	have an associated ID (this depends on the event type), then this
+	is 0.
+
+.. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
+
+.. cssclass:: longtable
+
+.. _media-event-type:
+
+.. flat-table:: Media Event Types
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       3 1 4
+
+    * - ``MEDIA_EVENT_ALL``
+      - 0
+      - All events. MEDIA_EVENT_ALL is valid only for
+	MEDIA_IOC_UNSUBSCRIBE_EVENT for unsubscribing all events at once.
+    * - ``MEDIA_EVENT_ENTITY_REGISTRATION``
+      - 1
+      - Triggered when a media entity is registered to a Media controller
+        device. The pending field designates the number of entities that are
+	known to be still missing. This number may be less than the total
+	number of all missing entities. However if this number is zero, then
+	all entities have been registered to the media device.
+
+Return Value
+============
+
+On success 0 is returned, on error -1 and the ``errno`` variable is set
+appropriately. The generic error codes are described at the
+:ref:`Generic Error Codes <gen-errors>` chapter.
+
+ENOENT
+    The event queue is empty and the file descriptor is in non-blocking
+    mode.
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-subscribe-event.rst b/Documentation/userspace-api/media/mediactl/media-ioc-subscribe-event.rst
new file mode 100644
index 000000000000..61e537b6ba6d
--- /dev/null
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-subscribe-event.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+.. c:namespace:: MC
+
+.. _media_ioc_subscribe_event:
+
+************************************************************
+ioctl MEDIA_IOC_SUBSCRIBE_EVENT, MEDIA_IOC_UNSUBSCRIBE_EVENT
+************************************************************
+
+Name
+====
+
+MEDIA_IOC_SUBSCRIBE_EVENT - MEDIA_IOC_UNSUBSCRIBE_EVENT - Subscribe or unsubscribe a Media controller event
+
+
+Synopsis
+========
+
+.. c:function:: int ioctl( int fd, MEDIA_IOC_SUBSCRIBE_EVENT, struct media_event_subscription *argp )
+    :name: MEDIA_IOC_SUBSCRIBE_EVENT
+
+.. c:function:: int ioctl( int fd, MEDIA_IOC_UNSUBSCRIBE_EVENT, struct media_event_subscription *argp )
+    :name: MEDIA_IOC_UNSUBSCRIBE_EVENT
+
+
+Arguments
+=========
+
+``fd``
+    File descriptor returned by :ref:`open() <media-func-open>`.
+
+``argp``
+    Pointer to struct :c:type:`media_event_subscription`.
+
+
+Description
+===========
+
+The MEDIA_IOC_SUBSCRIBE_EVENT IOCTL may be used to subscribe Media controller
+events to the file handle. The events are identified by their type and id, and
+the user may set the flags field to specify properties of the subscription. The
+subscriptions are specific to a file handle.
+
+The caller is responsible for setting the value of all fields in the argument
+struct by either initialising the fields of the entire struct to a known value
+or by setting the memory of the entire struct to zero and then filling the
+desired fields.
+
+The events may be dequeued using the :ref:`MEDIA_IOC_DQEVENT` IOCTL.
+
+The MEDIA_IOC_UNSUBSCRIBE_EVENT IOCTL is used to unsubscribe a subscribed
+event. A special value of ''MEDIA_EVENT_ALL'' may be used to unsubscribe all
+events on a file handle.
+
+.. tabularcolumns:: |p{4.6cm}|p{4.4cm}|p{8.7cm}|
+
+.. c:type:: media_event_subscription
+
+.. flat-table:: struct media_event_subscription
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u32
+      - ``type``
+      - Type of the event, see :ref:`media-event-type`.
+
+	.. note::
+
+	   ``MEDIA_EVENT_ALL`` can be used with
+	   :ref:`MEDIA_IOC_UNSUBSCRIBE_EVENT <MEDIA_SUBSCRIBE_EVENT>` for
+	   unsubscribing all events at once.
+    * - __u32
+      - ``id``
+      - ID of the event source. If there is no ID associated with the
+	event source, then set this to 0. Whether or not an event needs an
+	ID depends on the event type.
+    * - __u32
+      - ``flags``
+      - Event flags, see :ref:`media-event-flags`.
+    * - __u32
+      - ``reserved``\ [5]
+      - Reserved for future extensions. Drivers and applications must set
+	the array to zero.
+
+.. tabularcolumns:: |p{6.8cm}|p{2.2cm}|p{8.5cm}|
+
+.. _media-event-flags:
+
+.. flat-table:: Media event Flags
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       3 1 4
+
+    * - ``MEDIA_EVENT_SUB_FL_SEND_INITIAL``
+      - 0x0001
+      - When this event is subscribed an initial event will be sent
+	containing the current status. This only makes sense for events
+	that are triggered by a status change such as ``V4L2_EVENT_CTRL``.
+	Other events will ignore this flag.
+
+
+Return Value
+============
+
+On success 0 is returned, on error -1 and the ``errno`` variable is set
+appropriately. The generic error codes are described at the
+:ref:`Generic Error Codes <gen-errors>` chapter.
+
+EINVAL
+    The struct :c:type:`media_event_subscription` specifies an event that may not
+    generated by the given Media device.

-- 
2.56.0

