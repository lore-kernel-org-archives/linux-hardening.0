Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101378;
	b=3qK0DWQzYXT5Tv3Dl5Ubj6kp6TBAw63koAwhmnd1WZuGE9sn/gSf9wRqrnJvSZzyd0O7
	 XmAy4SGYdONd8cuiKX1g46WDhzak64eBr2tpdxJESCj0/0O6uX+xOPCmwhzd7rxIxtBkO
	 iAfDX7mGQH/yvdKMJco6cMbSXcYPS8dByvQQr4J5InpP9qL9wxiKJSSilOvGD0lmkqT2G
	 0CvuliA7pC0LMuMnXnQuH2NO/jis3Y2InUzXd01EV6YjjODPC0pU4A2ejhRSZp+QdYf2S
	 LeN2iU1yuYXiNmWeQnksY/kGF9eztkEbHJrDJJfpZLdQrCbRILV5GG0Wzjl7Y4YkB0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=IFKYyZe98olIOt/z7FVjqJN0LXwahHsaIWrhXMheXUY=;
	b=e9HhyqOPXkJNjRslKc007NI3klbfZgaPcr6FmslhRCcFNb1jZ+Da0Zx3Ng8dkJU3OVom
	 /fA/z1KUcyoTooILzheBAdUWpcbRT6t2dG7L2h0PBfCyoOyWOHPjnVLWHjb4tTUmodQme
	 HOt3sJsQ/osMag+rawEPimTYAVDoi08hFDg2WAzFsIw+7755HREz2U4KYKm0cew3ZxWyS
	 gWYbqC3408JXWG24WjpE/ABGdq7dZUqzWFUIvRsQfZuanqpOUZRcmVxs0p5XDiA0Yzj4R
	 NBwCTSDfZdh5aMiljZ0yNsyxKhMXWektt5epjbLeZ/Yc8C+ro8G/xHi0JenPPmz6ymw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ELiSdUOH;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B1606A331
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 11:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1B1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ELiSdUOH
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1928466a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793101377; x=1793706177; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFKYyZe98olIOt/z7FVjqJN0LXwahHsaIWrhXMheXUY=;
        b=ELiSdUOH/cIJPyFJHbgZeLUlxA1ZsPoFOAPtjqLzx/rzQ9JO7MiO1l1EylHRSz9ezg
         ictUVQ2uhhQ2pYHxEdBrFH5HIDKQqTiAHMzqlnq5QD5CgC6J+EP2q6pJpZRC73jUwRhD
         ylqMz+7fKAuQWhpAwt6wJQNE9JgQDJ+tXRAss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101377; x=1793706177;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IFKYyZe98olIOt/z7FVjqJN0LXwahHsaIWrhXMheXUY=;
        b=mvHHWdB6CZvfO2Dp+HiAWxin3MZi7MLj5br0SWMC42HfH9WkI4JqWI5PQzSurs3qbw
         MlZJM380N1Fr8UAOeXyoOVdKByxxRq/DF08Dz6X8Ioewj9jhna3Xw4yDz1sz27U9RY6G
         D1ArZacMydHhvGf1Rc4KUzV4LM7N0lfgLCOfQGfM67ozWVEmRoA/s6fi4XtBLXoZHXQ2
         Y9gj5dJXIH0msGyHIxtIMzM+XjPVUE04GbrPaw9p6hno+SoNInDWRkDoQBYke6YUkAUQ
         734FnC69UocjSFqTD9paKIFGLBggLojfeOwCz/4nH/o5jiM5L6g5II4wzbV0MoGGnlz8
         WMfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9E5V35E7bWmZgRVckYid+fzEAVEcOW0FCUS90ywtKQRlYZmuu/zbks89N6J6BFl1aJUGjLGiPC1pSHsyy+iQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYItuDw07P4tO9eHYDpIP3iyKkUrsi4oJQ8WyXCkMsEXdGDcEZVJ
	mEgdNoMGy5QQp9mOVjk0NlOHWJet2mIdzolqpqua3n3Ie4x42IVtlK6LNgeSbc+mPT4=
X-Gm-Gg: AYBFou3D3HE+OOfXoyZlH0IBhuatXdXVi4bceB6PLcZBytvwiMbiTQN3AK5PECKg//P
	xWTpcfYPMsNmYCXnZuj7Rrxzn5vENhEd74bs/vBaimMTNEaV0u5+Ob9Ctz504HKrIoNlpXXcLsH
	LKUSbzAt/GZnUHHmkoqNd85o+Ma6uVyHhCLV668CwClLXWV7TOIZwp+D4IrnlMbL/2WatoJafeZ
	eijm0t5Yp8e/Hh/ubdqkdl0zZXVn+akz4C4tcoYk7go/fwGRtIKkGg5v5V9f5tqV/CqghkTeILU
	N+XDmDk6/VCJNgmZveVC2egPSYD52AvQrhSIhvRXUIF6blOAJTfC/gU3sGvBndjC0raDGOF8WRS
	6bwBmBFe/KoEgqlfm3DSv8LM6r+XBLSAb0Z6cbL58OJAL1OM5p9/iFV4AorXk8vOTODdQJBOPsT
	+W7zD+4CLG5DXGPKr8skGDZa+/3/fAxtTLTKO4LiIvPLnUzyruYdx7RXpNHCCSEGqn1kq4xY3Xc
	TQDBQvmDMzvCwhs8KGH/koBJSNO2gcdUGufUcgu0llK+Gt9w/oLvkCWXm/d+kQFVWpqyn4KXZcg
	B6BsRDSXt/SxU6fv/ybQ5YaTIEQ0UCtng/yy/D4+jyzyacvnAVNPWfoSiRxAZOWeRYW2zM4GA5Y
	WRDTqug3S/bWKD59ewd8FUtTZde+r+ORYkR/MzDyLX1Y7mPTpOK+xh2L1gmHzzOEbo/DxlF18
X-Received: by 2002:a17:90a:d888:b0:3ac:80dc:f419 with SMTP id 98e67ed59e1d1-3adeae7309cmr8343178a91.25.1793101377141;
        Tue, 27 Oct 2026 04:42:57 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm3637757a91.7.2026.10.27.04.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:42:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:42:54 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 0/3] mseal sysmap: Choose system mapping sealing at boot
Message-ID: <cover.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

System mapping sealing is currently a build time choice. Hosts which
want it and hosts which need to move or unmap these mappings therefore
need separate kernels, which is not ideal. Let's allow the administrator
to choose at boot time.

Chris Down (3):
  mseal sysmap: Add mseal_system_mappings= boot parameter
  mseal sysmap: Allow with CHECKPOINT_RESTORE, default off
  selftests/mseal_system_mappings: Test vdso unmap and remap

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/userspace-api/mseal.rst         |   5 +-
 include/linux/mm.h                            |   3 +-
 mm/mseal.c                                    |  13 +
 security/Kconfig                              |  17 +-
 .../selftests/mseal_system_mappings/Makefile  |   2 +
 .../selftests/mseal_system_mappings/config    |   2 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 236 ++++++++++++++++--
 8 files changed, 268 insertions(+), 17 deletions(-)


base-commit: bae9a042b03b27924c6fd5bdc00a20d6a44d6041
-- 
2.54.0

