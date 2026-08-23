Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A25B098;
	Sun, 23 Aug 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787493015; cv=none; b=RC1fWce4/xhkj9SKfTYbftafqnCYqsDl6QUD1i3gCWMEuy7JneE79YcOD+iPBUdPybPUUIfiF1/ejbVJYS/C6ZP6eRn+lYsoQ/g1gsZYyjMqxErlEaH68NXxJht6hCfaAFZPmKRi+bfy5MMTbVueQOx1W/p/akEI4gJjCSJP27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787493015; c=relaxed/simple;
	bh=S+9NAgLueA2RZeynICi0Yvh3UbMjI9/VvOJpJw+8GWI=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BZy4K7QExppRtKXp72AA/WVRX+fl8+4gM2KAPjMg++wd2jMh/iXaBdaEGGFhzttdHBQ4AS6k0CMYgNrWTK4eSrJqu53ItO49tMMWA5z4DGDW042ZQDa9v0Q6Zpf5IT4EVNM+AHJj4OjTEgf/XhIxyzcS9DY3sgLkMGmpqVi3BoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=tzIcKpnM; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="tzIcKpnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787493009;
	bh=Ks1WdPiVgRZfpn4BYQoGQ8Zw0N7GSgh/nv5YbF2b2+k=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=tzIcKpnMAVRzfdQwPDRWg8K3zjPiYblt2aVXSkNNno8g8kMjo3eNSOyn3M55PxId/
	 kG2F5+bg/RJZCxzBAI4ABo7Ui2xReovtzHcwjbbFCksEamH4k0W1mUZeSNpNKKGDPe
	 t2jbDBrh/Tj9XhQGssCFDV7VfbvoEYjqr7+RvViE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hSb5Y4LMNz10xc;
	Sun, 23 Aug 2026 13:50:09 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hSb5Y0dTjz10xM;
	Sun, 23 Aug 2026 13:50:09 +0000 (UTC)
Date: Sun, 23 Aug 2026 14:50:08 +0100
From: Bradley Morgan <include@grrlz.net>
To: morbo@google.com
CC: aliceryhl@google.com, brauner@kernel.org,
 codemender-patching+linux@google.com, cyphar@cyphar.com,
 dianders@chromium.org, gary@garyguo.net, gustavoars@kernel.org, jack@suse.cz,
 kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux.amoon@gmail.com, nathan@kernel.org,
 nsc@kernel.org, ojeda@kernel.org, oleg@redhat.com, tglx@kernel.org,
 thomas.weissschuh@linutronix.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_userns=3A_Add_=5F=5Fcounted=5F?=
 =?US-ASCII?Q?by=5Fptr_attribute_to_struct_uid=5Fgid=5Fmap?=
In-Reply-To: <20260823125155.1136740-2-morbo@google.com>
Message-ID: <81CC73A5-FF7A-4456-9B04-69E1DD0D85DF@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 23 August 2026 13:51:47 BST, Bill Wendling <morbo@google.com> wrote:
>The compiler attribute __counted_by_ptr associates a pointer field of a
>struct with a sibling field within the same struct that specifies the
>element count of the allocated memory. This enables KASAN and fortified
>bounds-checking to detect out-of-bounds accesses to the pointer field at
>runtime.
>

Ack.

>We can add the __counted_by_ptr attribute to the 'forward' and 'reverse'
>pointer fields of 'struct uid_gid_map', which are counted by
>'nr_extents'. Since 'nr_extents' is defined in a sibling anonymous
>struct inside an anonymous union, the nearest common non-anonymous
>struct level is 'struct uid_gid_map' itself, which is supported by the
>compiler.

love it.


>However, doing so has runtime implications. In the original
>implementation of insert_extent(), elements are written to
>map->forward[map->nr_extents] before map->nr_extents is incremented:
>

Resounding ack.


>	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
>		dest = &map->extent[map->nr_extents];
>	else
>		dest = &map->forward[map->nr_extents];
>
>	*dest = *extent;
>	map->nr_extents++;
>
>At the time of writing to 'map->forward[map->nr_extents]',
>map->nr_extents is still 5, but we are accessing index 5 (which is the
>6th element). Under __counted_by_ptr(nr_extents), the compiler and
>KASAN expect the accessed index to be strictly less than
>map->nr_extents. Therefore, accessing index 5 when the count is 5
>triggers an out-of-bounds panic/trap at runtime.

oh!


>To resolve this, insert_extent() is refactored to increment
>map->nr_extents first, and then use map->nr_extents - 1 as the index:
>
>	map->nr_extents++;
>	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>		dest = &map->extent[map->nr_extents - 1];
>	else
>		dest = &map->forward[map->nr_extents - 1];
>
>	*dest = *extent;
>
>Assisted-by: Gemini Next

Id like to wonder what the hell that model is Gemini 3.5 pro?, I gave it a
Google and saw nothing.

Btw. 

Reviewed-by: Bradley Morgan <include@grrlz.net>




>Signed-off-by: Bill Wendling <morbo@google.com>
>---
>Cc: Kees Cook <kees@kernel.org>
>Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>Cc: Christian Brauner <brauner@kernel.org>
>Cc: Aleksa Sarai <cyphar>
@cyphar.com>
>Cc: Jan Kara <jack@suse.cz>
>Cc: Nathan Chancellor <nathan@kernel.org>
>Cc: Miguel Ojeda <ojeda@kernel.org>
>Cc: Thomas Gleixner <tglx@kernel.org>
>Cc: Nicolas Schier <nsc@kernel.org>
>Cc: Gary Guo <gary@garyguo.net>
>Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
>Cc: Alice Ryhl <aliceryhl@google.com>
>Cc: Douglas Anderson <dianders@chromium.org>
>Cc: Anand Moon <linux.amoon@gmail.com>
>Cc: Oleg Nesterov <oleg@redhat.com>
>Cc: codemender-patching+linux@google.com
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-hardening@vger.kernel.org
>---
> include/linux/user_namespace.h | 4 ++--
> kernel/user_namespace.c        | 8 ++++----
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>index e38d9e60569f..2962256eddf7 100644
>--- a/include/linux/user_namespace.h
>+++ b/include/linux/user_namespace.h
>@@ -29,8 +29,8 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> 			u32 nr_extents;
> 		};
> 		struct {
>-			struct uid_gid_extent *forward;
>-			struct uid_gid_extent *reverse;
>+			struct uid_gid_extent *forward __counted_by_ptr(nr_extents);
>+			struct uid_gid_extent *reverse __counted_by_ptr(nr_extents);
> 		};
> 	};
> };
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index 0bed462e9b2a..7e5371d8f515 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -809,13 +809,13 @@ static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
> 		map->reverse = NULL;
> 	}
> 
>-	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
>-		dest = &map->extent[map->nr_extents];
>+	map->nr_extents++;
>+	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>+		dest = &map->extent[map->nr_extents - 1];
> 	else
>-		dest = &map->forward[map->nr_extents];
>+		dest = &map->forward[map->nr_extents - 1];
> 
> 	*dest = *extent;
>-	map->nr_extents++;
> 	return 0;
> }
> 
>

Thanks!
