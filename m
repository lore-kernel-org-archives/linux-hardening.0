Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E519C54F;
	Sun,  6 Jul 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823454; cv=none; b=miF052BopuVSrirVZ8feXNPjF+H91A5lOxrifkJwjuNlrOC4eG4qTBQfd+G/OZ/U0ZPd/tStpnx4rVvpC5izuHjtSEIPc1e80sV5H4tu0leoQrKCgfYoDq0CtDVQbycWVIDSdRGIuARCfDLcErylvL5J2dcK03BvLwdSPgMObx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823454; c=relaxed/simple;
	bh=ovktrmFqgAtBsSi2ZsROA0X6b8FGHHeHhSSb81Ojs6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QI91X7hy+Y4z/fKJK5KehVhaY2eA5qtEbH33UI7BvQHJ+PDoLLkq0IHXsJb9TDMvyr3xeYUw8f6h9tmBKSeUs68qsTmlbEArft/l3H96mY5gOtJPMZNUaO8ccqmZ4k5GWUXwzQfNNCmYun6b0Oa255eGMOanrnvYisJAhznyGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxfjiZoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxfjiZoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93105C4CEED;
	Sun,  6 Jul 2025 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751823453;
	bh=ovktrmFqgAtBsSi2ZsROA0X6b8FGHHeHhSSb81Ojs6s=;
	h=Date:From:To:Cc:Subject:From;
	b=mxfjiZoSfrtIsbdPdv/fpyMPc7LfJvD+F03tsE/rydIotMh8gluN1pIEyQnsqVByM
	 6HPzmlMLHoFb8vz1rVkUelZ/9vtc3AydYiza4o9RMA6lyy6cLRZOVMp28i91gHt3q/
	 ny3XAyB+IQFU1DOZjab9IzyfZ6+/f0f79858wG2uo/9yVdDMHGwJC7wS+sZpyxUaQ8
	 x6C9hPnplkC2au3JPtwxD28Nkrmqm26a6r4iN5QmkbpW8rfOF2zBH6s6d5orzx2H7p
	 HXI9NleViYCNjz+W8EUTAhQJuHpakBE7alC4cFbCZntKnzUcJczq2axXIm+PiQDIar
	 SOHAQ+GDM86IQ==
Date: Sun, 6 Jul 2025 19:37:32 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v2 0/5] Add and use seprintf() instead of less ergonomic APIs
Message-ID: <cover.1751823326.git.alx@kernel.org>
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

I've found some more bugs in the same code.  There were three off-by-one
bugs in the code I had replaced, and while I had noticed something
weird, I hadn't stopped to think too much about them.  I've documented
the bugs, and fixed them in the last commit.  I've also added an ENDOF()
macro to prevent these off-by-one bugs when we can avoid them.

This time I've built the kernel, which showed I had forgotten some
prototypes, plus also one typo.

See range-diff below.

This is still not complying to coding style, but is otherwise in working
order.  I'll send it as is for discussion.  When we agree on the
specific questions on the code I made in v1, I'll turn it into coding-
style compliant.


Have a lovely Sun day!
Alex

Alejandro Colomar (5):
  vsprintf: Add [v]seprintf(), [v]stprintf()
  stacktrace, stackdepot: Add seprintf()-like variants of functions
  mm: Use seprintf() instead of less ergonomic APIs
  array_size.h: Add ENDOF()
  mm: Fix benign off-by-one bugs

 include/linux/array_size.h |   6 ++
 include/linux/sprintf.h    |   4 ++
 include/linux/stackdepot.h |  13 +++++
 include/linux/stacktrace.h |   3 +
 kernel/stacktrace.c        |  28 ++++++++++
 lib/stackdepot.c           |  12 ++++
 lib/vsprintf.c             | 109 +++++++++++++++++++++++++++++++++++++
 mm/kfence/kfence_test.c    |  28 +++++-----
 mm/kmsan/kmsan_test.c      |   6 +-
 mm/mempolicy.c             |  18 +++---
 mm/page_owner.c            |  32 ++++++-----
 mm/slub.c                  |   5 +-
 12 files changed, 221 insertions(+), 43 deletions(-)

Range-diff against v1:
1:  2d20eaf1752e ! 1:  64334f0b94d6 vsprintf: Add [v]seprintf(), [v]stprintf()
    @@ Commit message
         Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
     
    + ## include/linux/sprintf.h ##
    +@@ include/linux/sprintf.h: __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
    + __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
    + __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
    + __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
    ++__printf(3, 4) int stprintf(char *buf, size_t size, const char *fmt, ...);
    ++__printf(3, 0) int vstprintf(char *buf, size_t size, const char *fmt, va_list args);
    + __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
    + __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
    ++__printf(3, 4) char *seprintf(char *p, const char end[0], const char *fmt, ...);
    ++__printf(3, 0) char *vseprintf(char *p, const char end[0], const char *fmt, va_list args);
    + __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
    + __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
    + __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
    +
      ## lib/vsprintf.c ##
     @@ lib/vsprintf.c: int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
      }
2:  ec2e375c2d1e ! 2:  9c140de9842d stacktrace, stackdepot: Add seprintf()-like variants of functions
    @@ lib/stackdepot.c: int stack_depot_snprint(depot_stack_handle_t handle, char *buf
     +	unsigned int nr_entries;
     +
     +	nr_entries = stack_depot_fetch(handle, &entries);
    -+	return nr_entries ? stack_trace_seprint(p, e, entries, nr_entries,
    ++	return nr_entries ? stack_trace_seprint(p, end, entries, nr_entries,
     +						spaces) : p;
     +}
     +EXPORT_SYMBOL_GPL(stack_depot_seprint);
3:  be193e1856aa ! 3:  e3271b5f2ad9 mm: Use seprintf() instead of less ergonomic APIs
    @@ Commit message
     
         mm/kfence/kfence_test.c:
     
    -            The last call to scnprintf() did increment 'cur', but it's
    -            unused after that, so it was dead code.  I've removed the dead
    -            code in this patch.
    +            -  The last call to scnprintf() did increment 'cur', but it's
    +               unused after that, so it was dead code.  I've removed the dead
    +               code in this patch.
    +
    +            -  'end' is calculated as
    +
    +                    end = &expect[0][sizeof(expect[0] - 1)];
    +
    +               However, the '-1' doesn't seem to be necessary.  When passing
    +               $2 to scnprintf(), the size was specified as 'end - cur'.
    +               And scnprintf() --just like snprintf(3)--, won't write more
    +               than $2 bytes (including the null byte).  That means that
    +               scnprintf() wouldn't write more than
    +
    +                    &expect[0][sizeof(expect[0]) - 1] - expect[0]
    +
    +               which simplifies to
    +
    +                    sizeof(expect[0]) - 1
    +
    +               bytes.  But we have sizeof(expect[0]) bytes available, so
    +               we're wasting one byte entirely.  This is a benign off-by-one
    +               bug.  The two occurrences of this bug will be fixed in a
    +               following patch in this series.
    +
    +    mm/kmsan/kmsan_test.c:
    +
    +            The same benign off-by-one bug calculating the remaining size.
     
         mm/mempolicy.c:
     
-:  ------------ > 4:  5331d286ceca array_size.h: Add ENDOF()
-:  ------------ > 5:  08cfdd2bf779 mm: Fix benign off-by-one bugs
-- 
2.50.0

