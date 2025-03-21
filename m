Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9C78F5B
	for <linux-hardening@vger.kernel.org>; Fri, 21 Mar 2025 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527599; cv=none; b=CbWqeEeNDC65LtfBA8PUvfrQEf5XERgdWL13YXx0nJHaXQBdMLqYYo59PgUkd6E5EYgMrV2AH/d8EAUZQmJ8vzxZiglYqK5xCvwa032WGL7gBVj+H4YjxKoMqt6y19ErJcmFZE6pn7U3vjbv5B4pVHSMywTFPPDx7FJRctVNcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527599; c=relaxed/simple;
	bh=eDQh0a02ekUcaBQfvdbuK9jfyLKr14ZSzQwradln/NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWkn4vpDEnjBze4FlnBcJ6B9USWDDpHn1dXrcEwWu8UeL8KfisaY0hsqlnVSvjMLXXqbVZHSkTBqEj4ddV35kjg86xK0o6yXH1w7VNFa3FspSp234YAxrieukHWF/TqCcZWZTRb6eXRtNMXhKxMM1bKlDi6Z3osdBh2+cRthIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aez4GEnK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aez4GEnK"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e835ffcf71so304272a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Mar 2025 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742527594; x=1743132394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5zHL19slUgh5eKmO5Fy/udQUm9kmXxLzG4bF5IRJCI=;
        b=aez4GEnKLLbKCLzOYF7r6c3fKtcNBNFiH1GRKupXt0ZGH/jGXFWjE60TRwASPHMTvc
         T4gwJv+AJZWiOhbCxACPrQJiw28b1aAZvlIrQaV4ylvODNpY8dUO2ooaxm+HI/4ff3Yt
         uJHg2zEp8zAQjXYIjy27coDzc6ejFqxiBJLK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742527594; x=1743132394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5zHL19slUgh5eKmO5Fy/udQUm9kmXxLzG4bF5IRJCI=;
        b=fe8+PG1SiKr5qSkyPEab9HWpUyA7KAxmZ6o1lT67LFyCQQ2MxglDj910A+CavKsTzj
         XnhsyeWSpDynRWDfk5/nAL3cqewLhOrVhVT3EAJfVWAagbekn5Su//8dvRZybAvoZMeQ
         p47UIFTfCPSivnsFuA4KC18PpxDkyeJJREb8w9TdWajBlJFv958DUM725BgFnJZgPK5o
         Eax/GdMTqJZH3r4PipZGpOaUFiZ8juKAJHQS5Jct46DVEeeLRctD3Qug4Zt0zAnBcbSr
         79Al3cIaLU3JVqmEMabrBQtvGwVD6zbiGmcpK1SBvADOiELGlWKALwQeYZ3b+p5Tthsq
         xbvg==
X-Forwarded-Encrypted: i=1; AJvYcCVAQ9QK/+bZAALkiBpQt4clmr4u6NQjUZ5lsx9UA2hA6I1AKUhEpC7PrhgttA8j0V4GKtqe8/vrH96arwlSbPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7MGU5UDtxtCxUR3l57GJ/CKVA7CNxosG/EQdAjpuGnsXNK3+
	Qu6H1WG+EwxFEczBRagorRLe4TZio5my+JM/iqpNUpXHQI/GL88AcMIvQQ+Yxw==
X-Gm-Gg: ASbGncsisU+n8c24s7hcksgT3aF7/T5czzq6ExjS9bi5vQd3Uo4G4c+jDAA13t0U3S0
	vjDvcVdPiya68/lLG38cfecusL4YwD7RF9kNYLpKpon9h4lqvPCpD5xlB8JqCNEnK4kUdiO2LKc
	ZKVpenZERDPOo9WWOfHGcjQrA69Hby62ZOElDekmerZcmpPgBS2n7l7xugXd+fZuXrN+EltFqlI
	tfTTmqC/3OuVO5c7A99RZoB/8BW2hu09SrOV+2eeqjJtF8cN1VFm1UEF4BTIZOu+DDRi0R7J3PA
	ZMT5enxPrzKBfnvUA+DE7V3gRBb4VJYAI8/XdEkw6fAHgZG/LFvmahjtsAGjnD+8G2Z6JGk2zO4
	xcR9lI3niQ6c=
X-Google-Smtp-Source: AGHT+IHl+mYWvLUnotjGhidy8abObJGBDSJw+ITfNPlfAIWcj0UU6andhioYEzcvbk2yZoi1n9IkvA==
X-Received: by 2002:a17:907:7f94:b0:ac3:673a:2ab3 with SMTP id a640c23a62f3a-ac3f2297982mr54135866b.7.1742527593850;
        Thu, 20 Mar 2025 20:26:33 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3f24sm68463366b.57.2025.03.20.20.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 20:26:32 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	edumazet@google.com,
	geert@linux-m68k.org,
	gor@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	m-malladi@ti.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v2 0/1] mseal sysmap: add arch-support txt
Date: Fri, 21 Mar 2025 03:26:26 +0000
Message-ID: <20250321032627.4147562-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

History:
V2:
 - add hexagon,microblaze,openrisc,sh as N/A (Geert Uytterhoeven)

V1:
  https://lore.kernel.org/all/20250313000623.3192896-1-jeffxu@google.com/


Jeff Xu (1):
  mseal sysmap: add arch-support txt

 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

-- 
2.49.0.395.g12beb8f557-goog

