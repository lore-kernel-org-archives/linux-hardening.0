Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCjOs9c6"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01898D53
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 11:15:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso1129291b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162112; x=1700766912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itQbu3UftA7q2hw/NFSZTVr92javRTdC5UMmRHbj2Bw=;
        b=BCjOs9c6naNNxZanB9m+Z9Jyj8rWbEqdvk17Bt1XcfLKuEFp8bhCNpvLrltkKVX+5B
         Tffllcez6iqqM7u9PcaxmnNIgEwtozY5ADPhV1MQNPEqbAU+BVzcWYdOHhh9QrIyZR4E
         JYFX1VrB8QD5l8Et/yBKhLU4+h806cTYOBdZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162112; x=1700766912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itQbu3UftA7q2hw/NFSZTVr92javRTdC5UMmRHbj2Bw=;
        b=AbNWeQapPNbYX6WVb1VKvmyTCtOfmxIIExYd0HBosl52gLqqxtCUblZTKH9YIL4Xk8
         rSOH/LNF9UIX/+KoqM6hV3KlMwpknqO3mCtsJjOiTdzVxegGPcouFKnqwHimYYKBQMSg
         sDD7oMZZaCGWkhHS/F60axzwLovME9NlqBms1tI3ZW6hxU4B3auAYAAbVSJQcLO2W5g9
         To/Ea+sXTLAq2rlQWjwtUAKdqBftf8LYPkc6nL2MUw9JvivcyQ4k8ViAUtpnjTPmIQ6e
         NPoJywgTa4dPMpd4ciOwSuHbgynZMrJdvswR+JFy/uxHnHRO2ovoH3pg9wQV14eMN2vT
         gNpQ==
X-Gm-Message-State: AOJu0YwiFrH8XEGKGv12jwp6iNXUJ6XhP2hgxoqqjrFykeWue2QHNEoy
	eaTxC29Ym+FmBDG8kE1EZMXOYA==
X-Google-Smtp-Source: AGHT+IEM6j6q2J53dhIxEHjwnlzX0+Y1Bt56wxP95opav+UU+3PZtdnLeNzVZHJV+dtvRYhv3MmgTw==
X-Received: by 2002:a05:6a20:3d8f:b0:187:1c5c:49e4 with SMTP id s15-20020a056a203d8f00b001871c5c49e4mr9407286pzi.46.1700162112330;
        Thu, 16 Nov 2023 11:15:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a056a00124700b006b8bb35e313sm78111pfi.103.2023.11.16.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:15:12 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Geliang Tang <geliang.tang@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] samples: Replace strlcpy() with strscpy()
Date: Thu, 16 Nov 2023 11:15:10 -0800
Message-Id: <20231116191510.work.550-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297; i=keescook@chromium.org;
 h=from:subject:message-id; bh=8RWyq4KVPGbZtO3osk9HAjbi6tNH2MBW0RVY7xAVSV4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmo+7LLVFxN0AZHfhyD824mNHu4H1YNT5WEHd
 jCOwpvPjWiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZqPgAKCRCJcvTf3G3A
 JsMwD/9v8oRd7dP1JrSwAPMk6+Wswvsl7EXZsrd0/8AuGTD61idVFJ5KK8HyRX5hYiHBZnxo7As
 r6s7O1gn9jeyLRGyTfAsJgYpu1E/XxQobeTONUepIrI4s1dywUx2hoUUyP9Ml8Op5KxUTi0RPS9
 MGNT1NdfG4ALEnF9PRQar9EJ1oIE0MAvhkYb9VF536or88XpQWrDqnCDrdcZjVy3/wk1njAhYwg
 COO3z6PA0qnajm9+JBuCETaFmkQ/Zoi/0ixw21J8gh6u7sjr39cO5x0YNpKFpQebfzw33VQi6qw
 KVxqTC/xrJF/ZjVXTBu5xSpsQaxj7bv8GtKf9mzOU0K8fTURElEVbYxuvSjdwcasE2k8zSAg1Us
 6/X7QiYpsA2c3tR0eKs89X8PabH2lQjB13ieFi89p33YReO3PyohOGakL7CsJy/4xxbC/dchZV0
 7GjybpjDuzWkHP/0nNTH45WdYYsJ3YUUb8WWbMq/2TCr89yoExGFlMbPCCiPwbpe+uYFOhV524o
 AvUPhxWBVNK7Y6D2HUDICv7tyAwM4mceRYIJq/L0COQDTqNmGzq8IEOGcJHMfLT/smzsoCwg0Ug
 ux9FgCI7HS7BknE40dkd2DCfTEqKQmJ439MQnoGoa35x2F+OlFIr8e+cec/DI95Ep2gAUrRl+Kg
 DtD781K vmCi5Jzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 samples/trace_events/trace-events-sample.h |  2 +-
 samples/v4l/v4l2-pci-skeleton.c            | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1c6b843b8c4e..23f923ccd529 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -305,7 +305,7 @@ TRACE_EVENT(foo_bar,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->foo, foo, 10);
+		strscpy(__entry->foo, foo, 10);
 		__entry->bar	= bar;
 		memcpy(__get_dynamic_array(list), lst,
 		       __length_of(lst) * sizeof(int));
diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index a61f94db18d9..69ef788d9e3b 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -291,8 +291,8 @@ static int skeleton_querycap(struct file *file, void *priv,
 {
 	struct skeleton *skel = video_drvdata(file);
 
-	strlcpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
-	strlcpy(cap->card, "V4L2 PCI Skeleton", sizeof(cap->card));
+	strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
+	strscpy(cap->card, "V4L2 PCI Skeleton", sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
 		 pci_name(skel->pdev));
 	return 0;
@@ -597,11 +597,11 @@ static int skeleton_enum_input(struct file *file, void *priv,
 	i->type = V4L2_INPUT_TYPE_CAMERA;
 	if (i->index == 0) {
 		i->std = SKEL_TVNORMS;
-		strlcpy(i->name, "S-Video", sizeof(i->name));
+		strscpy(i->name, "S-Video", sizeof(i->name));
 		i->capabilities = V4L2_IN_CAP_STD;
 	} else {
 		i->std = 0;
-		strlcpy(i->name, "HDMI", sizeof(i->name));
+		strscpy(i->name, "HDMI", sizeof(i->name));
 		i->capabilities = V4L2_IN_CAP_DV_TIMINGS;
 	}
 	return 0;
@@ -845,7 +845,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Initialize the video_device structure */
 	vdev = &skel->vdev;
-	strlcpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
+	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
 	/*
 	 * There is nothing to clean up, so release is set to an empty release
 	 * function. The release callback must be non-NULL.
-- 
2.34.1

