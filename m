Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A9288CC;
	Fri, 11 Jul 2025 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198998; cv=none; b=tPo4KqDd5z5RZXAYE0m8kw7WXxrwb7cLUKhBfaRIBufpahxMzokSCneWfCIA4zks1JiS+/INibJ4iTZVIZ6zbJH2w3SXCeJeKcVPHaXslmnmZVZCEBnNjgU9ysv4hqKIKd1n1YU+e/aUxt9PZConllND/28eszLNvodoqVHTuPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198998; c=relaxed/simple;
	bh=nMqwPTuZCArqfvKgBl5seOh3ask1tIU2u8XOTytKLjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH9lySgOA4p/aJfdUrMFIhQt+/E1lLznQUxytaIFsBnsJKQZB0uEDwvuHvyqg4X9zc/sEP0ji/xITFr0LaerULpaD5G0WncFpL9BwfyVgWjC0Fa/6aLzS90vYMtLF9rORx/tFBQmuaTaSLBK/qp/mDUnWUH2GHqSWo5nKHE47tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZLNgHjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZLNgHjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2028BC4CEE3;
	Fri, 11 Jul 2025 01:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198997;
	bh=nMqwPTuZCArqfvKgBl5seOh3ask1tIU2u8XOTytKLjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZLNgHjXMeW05eCNVj21HjZxSP+L4pwwp9gPjl6qBWARya+EVCsulgPPii+foNDk+
	 wk4YSFLH7R8UrVmeYijLV9o6nLpH5A+PlHkyH1IBRFlXIzVleaqOCyXjad2IXHA19G
	 K28ywtc7aVBrUCmHOoDPSdS40fk8kfRKwBNXBBRqjd5ZNgBJXSDc+IBdDdVNyvDZ8f
	 aNTSCTCf6mn3WJVh63wI8MkJbozTbDTydM8dkQMc707/B3cbl6wSbEphXODxJGz0e3
	 Uj67Hzr+nxWPSMvihsa9ETDQp43trSNipHGUq9w+bN2YVZVRAWXHs7U+dyc1gYGs9E
	 Nt+xfK6GtUUYg==
Date: Fri, 11 Jul 2025 03:56:31 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: [RFC v6 0/8] Add and use sprintf_{end,trunc,array}() instead of less
 ergonomic APIs
Message-ID: <cover.1752193588.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

Hi,

Changes in v6:

[As commented in private to Linus, I assume the NAK from Linus in v5
 applies to the macro that evaluates twice.  This is resolved in v6, so
 I send assuming no NAKs to the overall patch set.]

-  Don't try to have a single function.  Have sprintf_end() for chaining
   calls and sprintf_trunc() --which is the fmt version of strscpy()--
   for single calls.  Then sprintf_array() --which is the fmt version of
   the 2-argument strscpy()-- for single calls with an array as input.
-  Fix implementation of sprintf_array() to not evaluate twice.

These changes are essentially a roll-back to the general idea in v3,
except for the more explicit names.

Remaining questions:

-  There are only 3 remaining calls to snprintf(3) under mm/.  They are
   just fine for now, which is why I didn't replace them.  If anyone
   wants to replace them, to get rid of all snprintf(3), we could that.
   I think for now we can leave them, to minimize the churn.

        $ grep -rnI snprintf mm/
        mm/hugetlb_cgroup.c:674:                snprintf(buf, size, "%luGB", hsize / SZ_1G);
        mm/hugetlb_cgroup.c:676:                snprintf(buf, size, "%luMB", hsize / SZ_1M);
        mm/hugetlb_cgroup.c:678:                snprintf(buf, size, "%luKB", hsize / SZ_1K);

   They could be replaced by sprintf_trunc().

-  There are only 2 remaining calls to the kernel's scnprintf().  This
   one I would really like to get rid of.  Also, those calls are quite
   suspicious of not being what we want.  Please do have a look at them
   and confirm what's the appropriate behavior in the 2 cases when the
   string is truncated or not copied at all.  That code is very scary
   for me to try to guess.

        $ grep -rnI scnprintf mm/
        mm/kfence/report.c:75:          int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
        mm/kfence/kfence_test.mod.c:22: { 0x96848186, "scnprintf" },
        mm/kmsan/report.c:42:           len = scnprintf(buf, sizeof(buf), "%ps",

   Apart from two calls, I see a string literal with that name.  Please
   let me know if I should do anything about it.  I don't know what that
   is.

-  I think we should remove one error handling check in
   "mm/page_owner.c" (marked with an XXX comment), but I'm not 100%
   sure.  Please confirm.

Other comments:

-  This is still not complying to coding style.  I'll keep it like that
   while questions remain open.
-  I've tested the tests under CONFIG_KFENCE_KUNIT_TEST=y, and this has
   no regressions at all.
-  With the current style of the sprintf_end() prototyope, this triggers
   a diagnostic due to a GCC bug:
   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108036>
   It would be interesting to ask GCC to fix that bug.  (Added relevant
   GCC maintainers and contributors to CC in this cover letter.)
-  The call sprintf_end(p, end, "") in lib/stackdepot.c, within
   stack_depot_sprint_end(), produces a warning for having an empty
   string.  This could be replaced by a strcpy_end(p, end, "") if/when
   we add that function.

For anyone new to the thread, sprintf_end() will be proposed for
standardization soon as seprintf():
<https://lore.kernel.org/linux-hardening/20250710024745.143955-1-alx@kernel.org/T/#u>


Have a lovely night!
Alex


Alejandro Colomar (8):
  vsprintf: Add [v]sprintf_trunc()
  vsprintf: Add [v]sprintf_end()
  sprintf: Add [v]sprintf_array()
  stacktrace, stackdepot: Add sprintf_end()-like variants of functions
  mm: Use sprintf_end() instead of less ergonomic APIs
  array_size.h: Add ENDOF()
  mm: Fix benign off-by-one bugs
  mm: Use [v]sprintf_array() to avoid specifying the array size

 include/linux/array_size.h |   6 +++
 include/linux/sprintf.h    |   8 +++
 include/linux/stackdepot.h |  13 +++++
 include/linux/stacktrace.h |   3 ++
 kernel/stacktrace.c        |  28 ++++++++++
 lib/stackdepot.c           |  13 +++++
 lib/vsprintf.c             | 107 +++++++++++++++++++++++++++++++++++++
 mm/backing-dev.c           |   2 +-
 mm/cma.c                   |   4 +-
 mm/cma_debug.c             |   2 +-
 mm/hugetlb.c               |   3 +-
 mm/hugetlb_cgroup.c        |   2 +-
 mm/hugetlb_cma.c           |   2 +-
 mm/kasan/report.c          |   3 +-
 mm/kfence/kfence_test.c    |  28 +++++-----
 mm/kmsan/kmsan_test.c      |   6 +--
 mm/memblock.c              |   4 +-
 mm/mempolicy.c             |  18 +++----
 mm/page_owner.c            |  32 +++++------
 mm/percpu.c                |   2 +-
 mm/shrinker_debug.c        |   2 +-
 mm/slub.c                  |   5 +-
 mm/zswap.c                 |   2 +-
 23 files changed, 237 insertions(+), 58 deletions(-)

Range-diff against v5:
-:  ------------ > 1:  dab6068bef5c vsprintf: Add [v]sprintf_trunc()
1:  2c4f793de0b8 ! 2:  c801c9a1a90d vsprintf: Add [v]sprintf_end()
    @@ Commit message
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
     
      ## include/linux/sprintf.h ##
    -@@ include/linux/sprintf.h: __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
    - __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
    - __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
    +@@ include/linux/sprintf.h: __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
      __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
    + __printf(3, 4) int sprintf_trunc(char *buf, size_t size, const char *fmt, ...);
    + __printf(3, 0) int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args);
     +__printf(3, 4) char *sprintf_end(char *p, const char end[0], const char *fmt, ...);
     +__printf(3, 0) char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args);
      __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
    @@ include/linux/sprintf.h: __printf(3, 4) int snprintf(char *buf, size_t size, con
      __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
     
      ## lib/vsprintf.c ##
    -@@ lib/vsprintf.c: int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
    +@@ lib/vsprintf.c: int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args)
      }
    - EXPORT_SYMBOL(vscnprintf);
    + EXPORT_SYMBOL(vsprintf_trunc);
      
     +/**
     + * vsprintf_end - va_list string end-delimited print formatted
    @@ lib/vsprintf.c: int vscnprintf(char *buf, size_t size, const char *fmt, va_list
     +char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args)
     +{
     +  int len;
    -+  size_t size;
     +
     +  if (unlikely(p == NULL))
     +          return NULL;
     +
    -+  size = end - p;
    -+  if (WARN_ON_ONCE(size == 0 || size > INT_MAX))
    -+          return NULL;
    -+
    -+  len = vsnprintf(p, size, fmt, args);
    -+  if (unlikely(len >= size))
    ++  len = vsprintf_trunc(p, end - p, fmt, args);
    ++  if (unlikely(len < 0))
     +          return NULL;
     +
     +  return p + len;
    @@ lib/vsprintf.c: int vscnprintf(char *buf, size_t size, const char *fmt, va_list
      /**
       * snprintf - Format a string and place it in a buffer
       * @buf: The buffer to place the result into
    -@@ lib/vsprintf.c: int scnprintf(char *buf, size_t size, const char *fmt, ...)
    +@@ lib/vsprintf.c: int sprintf_trunc(char *buf, size_t size, const char *fmt, ...)
      }
    - EXPORT_SYMBOL(scnprintf);
    + EXPORT_SYMBOL(sprintf_trunc);
      
     +/**
     + * sprintf_end - string end-delimited print formatted
6:  04c1e026a67f ! 3:  9348d5df2d9f sprintf: Add [v]sprintf_array()
    @@ Commit message
         array.
     
         These macros are essentially the same as the 2-argument version of
    -    strscpy(), but with a formatted string, and returning a pointer to the
    -    terminating '\0' (or NULL, on error).
    +    strscpy(), but with a formatted string.
     
         Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
         Cc: Marco Elver <elver@google.com>
    @@ include/linux/sprintf.h
      #include <linux/types.h>
     +#include <linux/array_size.h>
     +
    -+#define sprintf_array(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
    -+#define vsprintf_array(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)
    ++#define sprintf_array(a, fmt, ...)  sprintf_trunc(a, ARRAY_SIZE(a), fmt, ##__VA_ARGS__)
    ++#define vsprintf_array(a, fmt, ap)  vsprintf_trunc(a, ARRAY_SIZE(a), fmt, ap)
      
      int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
      
2:  894d02b08056 = 4:  6c5d8e6012f0 stacktrace, stackdepot: Add sprintf_end()-like variants of functions
3:  690ed4d22f57 = 5:  8a0ffc1bf43d mm: Use sprintf_end() instead of less ergonomic APIs
4:  e05c5afabb3c = 6:  37b1088dbd01 array_size.h: Add ENDOF()
5:  515445ae064d = 7:  c88780354e13 mm: Fix benign off-by-one bugs
7:  e53d87e684ef = 8:  aa6323cbea64 mm: Use [v]sprintf_array() to avoid specifying the array size

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.50.0

