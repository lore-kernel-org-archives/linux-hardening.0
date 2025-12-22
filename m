Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C83016F4
	for <linux-hardening@vger.kernel.org>; Mon, 22 Dec 2025 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435097; cv=none; b=QP1oy+AeLJ0SI+eieuVe1ixLRZe7yHUyPphZLOz+Y4KGa86SiZVYg0E1mV7ADW/qaICvXaa1RRpJezdY6FNRvdQHvd4vwWVwmNaaW6nO1dky/F9ndRFvmoc3W9dbY6pVGcWLkl/FWukZJBQQgecJhOVJkhEsJdw4ZpzLp3JXr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435097; c=relaxed/simple;
	bh=n4uTk6JujUshZIHOvlYzInxYcuTU4c5NJcNylTC9QPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WWa7MwMb0mDG4j+uFvFlQJ/xaL4bTV0Isgv5BmGHEAv8MRKapx049CLmuK/7Cz5jdJz1/FNQxJmhsxlxrScViVRysAPkXWQ7FZQn8SdVW83/liUCXEi+yTr0euOtHEc6p641eYYbdEqnMHEURlmS0dJ2942NYf9XeyOYDmCzRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5+IgbhD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5+IgbhD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so9640139a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Dec 2025 12:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435096; x=1767039896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJyrOGxlu0ScfVIWQXAbbLBtlLqeU/M6daVE2o6S+8M=;
        b=A5+IgbhDFW1GBrOYCd9yoeP6LVpa6uEkMQavd8EA+mlgm4e0HqlSMqap4Ks8f/TFm9
         m09wn6mc4y/vor+HQ8Yi6b5KTJdmsyu4jyLdn+xRvOM6smlXJIZnskBbjQPsSd8j11Uh
         2zYEqImfX8ctuw+GpIZ9efiaB7OFFlYNljuQ6hD76KNdN5TvYnFTCmd+xDibr5xN+1Lz
         kC9yvkb1BrKjajskcyxLyV9rkwecNyDX+InsIh0vYdZce7G/pQIh22ykI5xL6rSa/2T1
         uSERd8axDwRSNrqkouO3EW9tsAlJ8yrJTH0tgksCGyv6eErNKJSa/J3NQ4CiFC9gaX4P
         egkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435096; x=1767039896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJyrOGxlu0ScfVIWQXAbbLBtlLqeU/M6daVE2o6S+8M=;
        b=E1E72cQzWQlCobBZ3gL4G0/bdMqAJmbSbw1pd2piqs0GIw5doCoDP+TFO3QShR08aN
         MUkpnXWF8lfvKR0AdYMw1x2EiELXRImAPtOSWKBh9WYNp84BwLpBTCJ/mWfbG0Dd2/Sq
         wzAlB3IHwbUH6ftn/onu3Mh+ZmWze2XRUSUqxUS/pBv1N9YYgVjg9+gK7Vnzxm/AJ/ZE
         0ov3TXf9VlnF3n3EIjY854xTBQZeJmnkFqIP3svuWQfOy7JViBuD4ZYaWg4lnDkRumU2
         jt8VumgTei1yUxJQ3BAId5dsQJFvvcjeyGtqjZek/ohQTBST/bBP4slbVIEwysYXEufP
         qQOg==
X-Forwarded-Encrypted: i=1; AJvYcCV24Y1JDtYsbBfLIPBkX2RMMvPIBujx3ZGoA617owWJBFzO/2yxpiHJyEveruYdWgpZwNr6ulrodQ7Xs0yUjVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo8ilc/tx9fWcWY30nGDW9iXWXQ+jDjOvSChsBGbSl91Bs/RP
	5ISwnftTCGrVYrsTeKZfDrYr3dglCsJQm3KiQSdlaiSFkUJ+qQ8xW17+QfEX34QQSGv39q6QgO1
	/8UYqTMwWaYZ+7aq6H6GlB8qFx+7gbA==
X-Google-Smtp-Source: AGHT+IHuYKdQ5x164yb7PryotVkYr394zzpivyA8SkPxp1eaMzgRUNIdpkWI9Pa38anpX/MBv/MMg98T9PztL+Gp/ug=
X-Received: from dlc23.prod.google.com ([2002:a05:7022:397:b0:120:5f59:867])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2714:b0:11a:962:99c2 with SMTP id a92af1059eb24-121723091efmr8988677c88.38.1766435095697;
 Mon, 22 Dec 2025 12:24:55 -0800 (PST)
Date: Mon, 22 Dec 2025 20:24:15 +0000
In-Reply-To: <20251119225439.work.741-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119225439.work.741-kees@kernel.org>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=291; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=n4uTk6JujUshZIHOvlYzInxYcuTU4c5NJcNylTC9QPM=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeKz5PZdF4l+zJ15V2zFL8buuP17Nyf2yfoLvd6d/ao
 kcfJVsrOkpZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE6tkZGTatk/qcHSPI/miV
 KcOeG/ltBfcX6Jb+U/xlI7xNYceZn2wM/7T/Hi9ccc5n9vRDHw30FDLV7qTNyJn0/bEwW2GOUXb yahYA
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400582.1902051.3878925092193822803.b4-ty@google.com>
Subject: Re: [PATCH] module/decompress: Avoid open-coded kvrealloc()
From: Sami Tolvanen <samitolvanen@google.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Kees Cook <kees@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Daniel Gomez <da.gomez@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 19 Nov 2025 14:54:43 -0800, Kees Cook wrote:
> Replace open-coded allocate/copy with kvrealloc().
> 
> 

Applied to modules-next, thanks!

[1/1] module/decompress: Avoid open-coded kvrealloc()
      commit: 68e85558587e6bbb5c3ea3c8b4c71ab852e4b53e

Best regards,

	Sami

