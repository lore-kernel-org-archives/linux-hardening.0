Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28164320CD3
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787545139; cv=none; b=dF53fLxXEzMPJwO4kXNAoNIVas0EigFH7/Q12+wAbw1oiKGsyLJnaE9nsuZZTvlNzN0qRr8xRwTPG0IHI4ddxrFZ5WpHQeV/MgvrLzInNplwS6fqMIX+NE3JwZJeQsLjbIUDSUSHgK6TEL/zT5wY1afVBtNVmRRoz5HStVBOw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787545139; c=relaxed/simple;
	bh=nS4A+NchybDCdfnHKP20Oz/ng5hvzymgimYTO1P8eHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXAxwBBCIVnzHueGe7Cy6/jgJ/ptQICn/UXXQgwKn81k3Cucp/DJ7ACyHM97baaBF6IK9/+Uz4Kb+A6MdVrswgFToylCQD/+XX0RspdWNBscK48jfj01tcJNTVWGpwmzMBji9Y4HCjLhyg1eSx2ZcdHT8xNUI81VycDzETmk1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=OVLzQBJh; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="OVLzQBJh"
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id yCtbwuDK4JFmFyM95wocdT; Mon, 24 Aug 2026 04:18:51 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id yM94wImgA5NF3yM94wxgw6; Mon, 24 Aug 2026 04:18:50 +0000
X-Authority-Analysis: v=2.4 cv=GaMXnRXL c=1 sm=1 tr=0 ts=6a8bc62a
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=H2i3IdQ1AAAA:8 a=_2yia0w1AAAA:8 a=cm27Pg_UAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=QvW1E99Mpn-9JGso-gkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yHFHt033RfTVV2SKly0E:22 a=4yAS8WwzZ1jAEY03B-5r:22
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8kZ+OAVjrt0puTdYwpEBcjWR8PZJhZuagtN48t6yLfA=; b=OVLzQBJh4flZlKn5RBaoNAr5Lg
	rzbbZTph0mXAGrn+ahS5KhgjYpgea2dpqQ9EW2tRU6BczmgzFOZt9tuOTtVQ5Dn/T3HwsKYZSE9iC
	7Txk1tJYUnQUjL20t5FLw7uP2N8ZJ4sdmDcUYFOpFR60jMelTwFeKRWW5kGiFsRjrmudkdne147Y5
	zKVKYiMqi8tWiYMPHERs3b9pSckL10PMln/89Si9t8oC9i1MczeubMmKqyfYtfxVhC+G1Z7ED6H/Z
	CGm2s9JQQpqK2vOu256I6T9dDGLvchmHXuv8jinLQp+XAmgtJBAiA7yxpjQBwGVFa1DaB49CzNV7T
	HKrnXc0w==;
Received: from [59.16.68.142] (port=42382 helo=[192.168.0.146])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wyM90-00000000Vn4-25TD;
	Sun, 23 Aug 2026 23:18:46 -0500
Message-ID: <fb9cd161-e91d-4182-9f40-67048a97e9e0@embeddedor.com>
Date: Mon, 24 Aug 2026 13:18:02 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] userns: Add __counted_by_ptr attribute to struct
 uid_gid_map
To: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Alice Ryhl <aliceryhl@google.com>, Douglas Anderson <dianders@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 codemender-patching+linux@google.com, linux-hardening@vger.kernel.org
References: <20260823125155.1136740-1-morbo@google.com>
 <20260823125155.1136740-2-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260823125155.1136740-2-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 59.16.68.142
X-Source-L: No
X-Exim-ID: 1wyM90-00000000Vn4-25TD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.146]) [59.16.68.142]:42382
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBkxAlTT+YB5+y5SC6g20c6Pqozx7jUraMyWPwBrrZQBCtLEWUeKHEcTISQI6i+B7XdPpx1eWhcoqq1EKTuGNpgTe+a31py7teeVqSVQPWOR3HYsjUmA
 ru5vLKy5w2d+wgpN7EmVNzUIbheII1AmA5zHkH+8XzLqRZWoH+48aGqkseQSMsvpI9XNTkVJvavRheGsJjSeSWtmQ2FFvZEQz/83XyooSB8ReWKrb7LTT7ka



On 8/23/26 06:51, Bill Wendling wrote:
> The compiler attribute __counted_by_ptr associates a pointer field of a
> struct with a sibling field within the same struct that specifies the
> element count of the allocated memory. This enables KASAN and fortified
> bounds-checking to detect out-of-bounds accesses to the pointer field at
> runtime.
> 
> We can add the __counted_by_ptr attribute to the 'forward' and 'reverse'
> pointer fields of 'struct uid_gid_map', which are counted by
> 'nr_extents'. Since 'nr_extents' is defined in a sibling anonymous
> struct inside an anonymous union, the nearest common non-anonymous
> struct level is 'struct uid_gid_map' itself, which is supported by the
> compiler.
> 
> However, doing so has runtime implications. In the original
> implementation of insert_extent(), elements are written to
> map->forward[map->nr_extents] before map->nr_extents is incremented:
> 
> 	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> 		dest = &map->extent[map->nr_extents];
> 	else
> 		dest = &map->forward[map->nr_extents];
> 
> 	*dest = *extent;
> 	map->nr_extents++;
> 
> At the time of writing to 'map->forward[map->nr_extents]',
> map->nr_extents is still 5, but we are accessing index 5 (which is the
> 6th element). Under __counted_by_ptr(nr_extents), the compiler and
> KASAN expect the accessed index to be strictly less than
> map->nr_extents. Therefore, accessing index 5 when the count is 5
> triggers an out-of-bounds panic/trap at runtime.
> 
> To resolve this, insert_extent() is refactored to increment
> map->nr_extents first, and then use map->nr_extents - 1 as the index:
> 
> 	map->nr_extents++;
> 	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> 		dest = &map->extent[map->nr_extents - 1];
> 	else
> 		dest = &map->forward[map->nr_extents - 1];
> 
> 	*dest = *extent;
> 
> Assisted-by: Gemini Next
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Nicolas Schier <nsc@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   include/linux/user_namespace.h | 4 ++--
>   kernel/user_namespace.c        | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index e38d9e60569f..2962256eddf7 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -29,8 +29,8 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
>   			u32 nr_extents;
>   		};
>   		struct {
> -			struct uid_gid_extent *forward;
> -			struct uid_gid_extent *reverse;
> +			struct uid_gid_extent *forward __counted_by_ptr(nr_extents);
> +			struct uid_gid_extent *reverse __counted_by_ptr(nr_extents);
>   		};
>   	};
>   };
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 0bed462e9b2a..7e5371d8f515 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -809,13 +809,13 @@ static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
>   		map->reverse = NULL;
>   	}
>   
> -	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> -		dest = &map->extent[map->nr_extents];
> +	map->nr_extents++;
> +	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +		dest = &map->extent[map->nr_extents - 1];
>   	else
> -		dest = &map->forward[map->nr_extents];
> +		dest = &map->forward[map->nr_extents - 1];
>   
>   	*dest = *extent;
> -	map->nr_extents++;
>   	return 0;
>   }
>   

