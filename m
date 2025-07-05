Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD9136349;
	Sat,  5 Jul 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751747630; cv=none; b=ne0amdTRSQIjhDc+iMGEy9X7PoIIZ1hfkLt0TJ5GFZFRhDHihKechX94CssDFkhLW32rmzFVrarHg9p1YOfBwORcixKyWkxdVdDsH7ICOKfM8+63Xh7oaZBxpcrji3UgrNsRxKdkR/tHtGt7PDmeUOX4X61DMJjWd8sdWzsJvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751747630; c=relaxed/simple;
	bh=x8F3+UGkH0IUobmiunbvuYQ7a54OJbCXpvRPOub+do0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ofba/KPDBAiQosj8cW615VCDnhgeJTGzESIHxC8vxSgfNILSLcOxx+EZgpyc13Nw2LONIqdtQ2kryzgmaJ+RvJ5Vm/dVwjps7Lv9QkwmW/exe3jVnVArMFnM//yPJh4f98dm+9SXGRAJzEfV3mXHO6pX5l+mjmT8R6Hl/kB+6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpEYLkd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpEYLkd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74D0C4CEE7;
	Sat,  5 Jul 2025 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751747629;
	bh=x8F3+UGkH0IUobmiunbvuYQ7a54OJbCXpvRPOub+do0=;
	h=Date:From:To:Cc:Subject:From;
	b=IpEYLkd8kEl6uXR2s8odDBOdGh9Iy0F3L3ghw+a+MNOsL5u6hNSssi5RySaKpL8zD
	 j7XsdtYrQb2inxwQc/oj/iACXPxMAT6JuDBZPxed+KrvCRINHo56OHiqFrs1zro1h0
	 /KaRDJn8yFKwQrdY66bRBrQo/8i8vWuA4DdZ4Zl29n0a2Mp9mdlb94Y5KMIL5iBUFs
	 cEY5G/M0zNbDrNap/M/2KyWMG4gwX0JIcp0Ls79CBdDMZXuVvT9hE7KH1m/i1Wz/V3
	 l1VoUdNNXdq+eM0bPZiJxeLhC8pL7yU++KjoS0FrqIF4Qh+z8MFESeW2XTomxpU14U
	 N/WJW3lnVYQbg==
Date: Sat, 5 Jul 2025 22:33:47 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic APIs
Message-ID: <cover.1751747518.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Kees,

As I anticipated in private, here's an API that we're using in the
shadow project.  I've added it in the kernel, and started replacing some
existing calls to s*printf() calls, and it was a bug mine.

I haven't even built the code yet.  I present it for discussion only at
the moment.  (Thus, RFC, not PATCH.)  Also, I've used ==NULL style for
null checks, to be more explicit, even if that's against the coding
style.  I'll change that for the actual patches, but for now during
discussion, I prefer having the explicit tests for my own readability.

The improvement seems quite obvious.  Please let me know your opinion.
I also have a few questions for the maintainers of the specific code, or
at least for someone who deeply understands it, as I found some
questionable code.  (See the individual commit messages, and code
comments for those.)

On top of that, I have a question about the functions I'm adding,
and the existing kernel snprintf(3): The standard snprintf(3)
can fail (return -1), but the kernel one doesn't seem to return <0 ever.
Should I assume that snprintf(3) doesn't fail here?  (I have a comment
in the source code of the implementation asking for that.)

What do you think?

Alejandro Colomar (3):
  vsprintf: Add [v]seprintf(), [v]stprintf()
  stacktrace, stackdepot: Add seprintf()-like variants of functions
  mm: Use seprintf() instead of less ergonomic APIs

 include/linux/stackdepot.h |  13 +++++
 include/linux/stacktrace.h |   3 +
 kernel/stacktrace.c        |  28 ++++++++++
 lib/stackdepot.c           |  12 ++++
 lib/vsprintf.c             | 109 +++++++++++++++++++++++++++++++++++++
 mm/kfence/kfence_test.c    |  24 ++++----
 mm/kmsan/kmsan_test.c      |   4 +-
 mm/mempolicy.c             |  18 +++---
 mm/page_owner.c            |  32 ++++++-----
 mm/slub.c                  |   5 +-
 10 files changed, 208 insertions(+), 40 deletions(-)

Range-diff against v0:
-:  ------------ > 1:  2d20eaf1752e vsprintf: Add [v]seprintf(), [v]stprintf()
-:  ------------ > 2:  ec2e375c2d1e stacktrace, stackdepot: Add seprintf()-like variants of functions
-:  ------------ > 3:  be193e1856aa mm: Use seprintf() instead of less ergonomic APIs
-- 
2.50.0

