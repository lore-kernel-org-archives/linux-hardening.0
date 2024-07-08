Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05614884B;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466321; cv=none; b=pWhD/YFdaZBjrVjwdZpApmSiHEpY1TKEz+ZBameYF2HHNdfF8f0vMvGXlJojq2bTNma/9zGwkWistkkNlRTCr3dpvklXUzbloJDHb9T18/+LCpy9daTaHPFbkEF89sT9iSbFS/kpHzk65O6uVkuytqtQnzoPYF1LQuFiLW5KAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466321; c=relaxed/simple;
	bh=jpCq4pVTfojWK3+oCeJYOpZA2JMe3K30ZPhTJEPXTm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oWfIV3mzY55LKLJh/TPnXoKaBibV6fdXIqAcaYKJE1pdrwJbNK6ULsIH9kTXAP8DAgOz/SZbR4cy7S8soEFlrvTbEkdbASu5rgrv0jKojbhB2k+iMn+T46SPpuYT3ZHCzZpwnBwWkCqV4IYDExAdwhKkIiiSkP6bC6SHojo4bI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMf/gqVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMf/gqVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B586C4AF0B;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466321;
	bh=jpCq4pVTfojWK3+oCeJYOpZA2JMe3K30ZPhTJEPXTm8=;
	h=From:To:Cc:Subject:Date:From;
	b=LMf/gqVu5uTRk0qpjtAl6C6WIOTm/NNCxI+m+93d21QNSQao90lkJKvPBjg2Xa3Ca
	 1HrbP47Y3PRcM9ccO3bwTCBwyA+PwYDLo9tI1tE5hcxpu8PeJ7yeKNTMNNQiB+KCR4
	 JnmlSSfAbWtQEQwa25EpoO6MST19rEvfcnC59oCF/A2VkY3DVRIZyFe9thG+/hV8OQ
	 f6jZNaI0aN92iyHzCDocUEoYfKjsdQX12bGriTNiw0DKQxIc68mo7JQox0JhfZmvKI
	 yBvSJoKWxOBV8Z/911+/WuAg0Y7JFpRK/XNjdRsYK+OuLZUdeAgFYS1SnNiNPdbB5h
	 BWA545zg1JoZA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [RFC][PATCH 0/4] slab: Allow for type introspection during allocation
Date: Mon,  8 Jul 2024 12:18:34 -0700
Message-Id: <20240708190924.work.846-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994; i=kees@kernel.org; h=from:subject:message-id; bh=jpCq4pVTfojWK3+oCeJYOpZA2JMe3K30ZPhTJEPXTm8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjDuOdWe6mhcXvVpeyqZaFynSqIJTsDPGHDW8u N887JzMD3KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZow7jgAKCRCJcvTf3G3A JqNQD/9iGzvHNxNdqIroWI++R3Le0xfkoghMfcukyAXfd+WO0rVv9usm1/dp+nlarZSuOLiB77o DX1S/LAV1qjvXNDWg5zqRt3iQ+PIAe1b5nQNf7os09rqmWLsY9MBeP1NvrgWfvIsLI/tEExukpZ lWitYINFJ5BRrZ4yN51ZxKWnCPpX46Tnm5txNBdvVYMV14iJSRFxTMXja7ygZMsg2J2BJkjtufH wLDtR0lIJJKiNv82wFR69k2NILcfo8qNwQMerY8f+RuAnKhsLa5lBxjepgTvR1WO8CzPTLxEHde EQ6PMD+r5f9lRyS/Mao+IWfGW0sd1VxqsSytP+50jPdeC2v1my0x4onTw5g2TpJjiBWrUb7ta+M RBlnZovuwEG7S4fQFPGmXt04XXgS1Zd9ZSacnWdKq8Nt8wiPmSbxyAkOBWnO+ieZ548q+eDSKyf ySLjLlCrc36FGNOkjznqEWhUZ9+8lXUbdHUbW0MCM39P9g+6NtVPhj2S64Xq48HS3JLo2oSGM3V hh/tMV6uyjhyNNZEKhhV8G1Ekb19I0drtjcDYV14wDU/ptnK0K9XzKOwkspGLJV6SrUnOLGv15M TKwHW2154D1Qc6NtvOEK2YjztKPTed8cbXCgGMVSTXCgVHcAO8KmtiHBbEUZU5zAZauRw6Vptsv HobRXpQCnT9qT
 JQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This is an RFC for some changes I'd like to make to the kernel's
allocators (starting with slab) that allow for type introspection, which
has been a long-time gap in potential analysis capabilities available
at compile-time. The changes here are just a "first step" example that
updates kmalloc() and kzalloc() to show what I'm thinking we can do,
and shows an example conversion within the fs/pstore tree.

Repeating patch 3's commit log here:

    There is currently no way for the slab to know what type is being
    allocated, and this hampers the development of any logic that would need
    this information including basic type checking, alignment need analysis,
    etc.
    
    Allow the size argument to optionally be a variable, from which the
    type (and there by the size, alignment, or any other features) can be
    determined at compile-time. This allows for the incremental replacement
    of the classic code pattern:
    
            obj = kmalloc(sizeof(*obj), gfp);
    
    into:
    
            obj = kmalloc(obj, gfp);
    
    As an additional build-time safety feature, the return value of kmalloc()
    also becomes typed so that the assignment and first argument cannot drift,
    doing away with the other, more fragile, classic code pattern:
    
            obj = kmalloc(sizeof(struct the_object), gfp);
    
    into:
    
            obj = kmalloc(obj, gfp);
    
    And any accidental variable drift will not be masked by the traditional
    default "void *" return value:
    
            obj = kmalloc(something_else, gfp);
    
    error: assignment to 'struct the_object *' from incompatible pointer type 'struct foo *' [-Wincompatible-pointer-types]
       71 |     obj = kmalloc(something_else, gfp);
          |         ^
    
    This also opens the door for a proposed heap hardening feature that
    would randomize the starting offset of the allocated object within
    its power-of-2 bucket. Without being able to introspect the type for
    alignment needs, this can't be done safely (or cannot be done without
    significant memory usage overhead). For example, a 132 byte structure
    with an 8 byte alignment could be randomized into 15 locations within
    the 256 byte bucket: (256 - 132) / 8.


Thanks!

-Kees

Kees Cook (4):
  compiler_types: Add integral/pointer type helper macros
  slab: Detect negative size values and saturate
  slab: Allow for type introspection during allocation
  pstore: Replace classic kmalloc code pattern with typed argument

 fs/pstore/blk.c                |  2 +-
 fs/pstore/platform.c           |  2 +-
 fs/pstore/ram.c                |  3 +--
 fs/pstore/ram_core.c           |  2 +-
 fs/pstore/zone.c               |  2 +-
 include/linux/compiler_types.h | 23 +++++++++++++++++++++++
 include/linux/slab.h           | 32 +++++++++++++++++++++++++-------
 7 files changed, 53 insertions(+), 13 deletions(-)

-- 
2.34.1

