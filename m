Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03652D73A1
	for <linux-hardening@vger.kernel.org>; Sat, 23 May 2026 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779568902; cv=none; b=ZJxKNLK8k6ByVyaIa4KNbR0tU9U6TL9Q3OnMevxTEMjakJof0rtQOQslXe+g7wjzGBKcC04eXb6aGI/f9ph2fh1qrx9eYhglstZoreOQi0/Co1/D9gWTxxygkUr6UP777+SS8ioTFFedNJnqxhfSnMIxxMrHlVrA8ysvWkZA0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779568902; c=relaxed/simple;
	bh=ZDowhp0fPqZxjLyKA6nsScPxx0UPG3aBQPVBz7pM13k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/rLOfBftlS8S97oTGuUem1tVh8dRclN3oSkojuOF/QSgFAl03qVpT7zTe6g/Lia/KtzW3ZvkS0dhLIcCVPqmdNwCtNpNfF0pfEyfkdubhnYIgCcU8/uRn57XNtQVdg2sBsm6h5TkOU4AeRl2a7kj8u6OSjUGMmfoNYNAdZ1jCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEey0zje; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEey0zje"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so19001315e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 May 2026 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779568899; x=1780173699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNf7CFkgwF1rfbyNmnV/eQce4TyQWDhVxKWrw1dKd7E=;
        b=cEey0zjeHiEJzJmAYhGDpVwRE5q4kPPUsLVkgR+gb5HIAY7YTDnR8EOfdfWjWIMtUQ
         FhY5jOJK1L3/mnitQ3IzLdA7RvX5+17Zlx/kHH3xtynr5ML9IbvuleVjeI6joM98bCOC
         yWhKdy1XqWQDU/7zrBZ3nSm6LPNplC4VgU4eMGfi5OBmQpP1dXzvkIMg6qmJHijSIg+F
         qkWWbs9bg6YpAicPmjuntX6Aewg5mO6vVT/wmB2JlUxOS/ARIKG1zK71BWq17es4DkUZ
         nTQ5MOErJYtHq4o2s7U1eDedJkREZfiZJLDg9BiRMD+ecA6urwu8c7t9HSyx5t64c2Lo
         2FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779568899; x=1780173699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNf7CFkgwF1rfbyNmnV/eQce4TyQWDhVxKWrw1dKd7E=;
        b=iD358Eu12eAvy4Q1NPKAADjvUdQDeZLV9NlPAZ6jCtM8sX90SHLETSF5uT1Sy4GNzF
         MoFNq3aN2WXCxNLKR6hAP9b+AocbY/SGBFTO1IQutJMK8LwKM8NguVxiVC/wcRAXmJ2/
         GgCJRMnwus7a7W++d/SxmnMiM/TuJem7oDbvdTMa2ndgjg+1Kymank5K9ggn47yTkzbU
         s+P5WylH4jfG0t5inEgfyzOdBXYizH4IyXR+04GLd10sD7ReeAVz5j5Cp8ZaVchj6SVz
         Lsi3U/4sbi5LTcNmQI9LESOOKVdKsKSGPloYww8J50664HZbSaButEx35LOtIbpvxc+K
         /PwA==
X-Forwarded-Encrypted: i=1; AFNElJ+K6v+j2wFPIU2GRmkYdEnUYEcL7gYwFKuVfsE2uHYvG1EZ18NDLqyP7TawukAXolvHWvDQIx2dld32rfVnL1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUESFB3xx9XSKCgtZeZstxn7fIbqraQc/RCf4pzKxVTpa7UlfD
	pPLV64mxXZB1fWneguHcbNY4blwy+YdQbsgKFAXucMzkjg8fvnYCEw8d
X-Gm-Gg: Acq92OG88bYWAqx+rpm9MyR577A4QaRixAETuX4TEA6+dPbl0C1mjOD0fUB2oQtBNnR
	izQ2jgkiAplnGDLzzzwMZOZi3M4bm6T7MTHLxHiTBqgaIpRtKIFXpAicskMtGeh9U0dRaRhI4L+
	152sy8adX+DeE8JNriI0Pmb0rK0wVWfTZoQ8sDfyo9BuWpAHo4NON65MrIrYgS4TtRwRAupgYj5
	K3eMad4Wf+fQuvNHWrOXCxZt/ojUVL8kr7SrCITWOpWxTs/EvWubjP5XUdzLz1Et5n0yrGlXyU9
	cWm9AyUCvj5hS3/GCvAsxdsTXkssclds3EnO7tB2kRqAozATt2ran9gDnqOzA0MR1J1wCSmT2ne
	TDRH3VVHtg+VpdoKRIkSND5/w3BE0sLBev1duXk78dsL24RtYU0SsXmL2gW46+oDbaMwjfcn/T9
	R7/RomNg+GaPdyDzHjU5Uaw05x12eLm/gc/5e2JGU6
X-Received: by 2002:a05:600c:4746:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-4904225f7efmr126899095e9.3.1779568898911;
        Sat, 23 May 2026 13:41:38 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49059fb42dasm16015385e9.7.2026.05.23.13.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 13:41:38 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: axboe@kernel.dk,
	jack@suse.cz,
	jannh@google.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mjguzik@gmail.com,
	pfalcato@suse.de,
	viro@zeniv.linux.org.uk,
	David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with read-only files
Date: Sat, 23 May 2026 23:41:00 +0300
Message-ID: <20260523204100.553125-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <177918418452.771415.4371785688744608623.b4-reply@b4>
References: <177918418452.771415.4371785688744608623.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Let's discuss the other aggressive alternative: Can we try and
> unconditionally degrade to copy. This would affect sendfile(), splice(),
> and vmsplice(). Worst-case we would have to introduce the sysctl
> retroactively.
> 
> Thoughts?

I think as a first step we should make vmsplice unconditionally equivalent
to readv/writev.

vmsplice already was problematic from security point of view long time
ago. I mean CVE-2020-29374 (see https://lwn.net/Articles/849638/ ).

David Howells also doesn't like vmsplice:
https://lore.kernel.org/all/1763225.1769180226@warthog.procyon.org.uk/

Linus said in 2023:
> So I'd personally be perfectly ok with just making vmsplice() be
> exactly the same as write, and turn all of vmsplice() into just "it's
> a read() if the pipe is open for read, and a write if it's open for
> writing".
https://lore.kernel.org/all/CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com/

Even experts get vmsplice wrong, as can be seen in this thread:
https://lore.kernel.org/all/CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com/T/#u
As you can see in that thread, it is very hard to understand what vmsplice
man page supposed to mean. And you can also see that vmsplice is very
fragile.

-- 
Askar Safin
