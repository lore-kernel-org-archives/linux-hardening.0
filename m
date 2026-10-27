Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119237;
	b=AqdNB5kTsB/w3eW6kkiupXVKygM18mznqO1e0lg3XWHJGf1ScllEuRJb7QTkevnEzqpp
	 f0Be+qEzgMGQF3LRWZ4OzTn2SeMOrb5ZmKddjZLWP9MHjwrv97Tg6qpHZ4etCixk9V4B4
	 q4RqvnqysyAEZJiiw6CxrQFfMGlwxqLigHZnlDJmXQQXRgwYu3jGyWAuSLSSxdmd8fufk
	 t/uxEIvGYyAy8irkMmnVT70iOqZHvYjDNvYniOYpkZfED/Hfp1RXC8SrBjutfzAm7/Q/C
	 BLOV8a7hp5/IL2deap4cur/wnLrqbZlby8zY8BCisokfgp+PxZKqQ9LCNs+l3WKQreQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=0vGOrY3CisGPc8VMRVO//aXg6OQh93vx7xg6bEqOVs4=;
	b=a1OqbnZ/8al3VfiCUs9uLujLuvjTncefsQO7Sm8w9k8UaQNb+OXDYjxjrAuAwqUCVrWU
	 /RPtVmWzm7LiwZdmByqQMNEVuOo53iMq7LoFXrOjD03h7Z9SxT+iv07rH7Z/SOaKN2q9L
	 Pg7JnVOg/QbGDtbhBOfE0yXLZYt9khLFy3X3wjHxfX5DEKOXI+yRHUm0/ll0um3dAXUeM
	 p8zrWjNgYjkrvcCdXsazvAzBQ/DJ1FDl871PgDbEjQbugP6vaB3PMcqj3AVf1/cDnty0Q
	 vH5tlPsdu3L9WCivexpjm/kGokpHdftkfSQuJLtR5HGapFmEKNRut8Rd9HmQP5ZAgEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=B9pgIkEN;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB162606A31D
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB162606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=B9pgIkEN
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso62221a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793119235; x=1793724035; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0vGOrY3CisGPc8VMRVO//aXg6OQh93vx7xg6bEqOVs4=;
        b=B9pgIkENP1nZt32P35HL6R0QxS18tatDUdKB8+Mex6frfRryvJ9HnZJ7yNzfYATxhk
         mTrYNth1sJ7pCfjLGBXbFdbG3yuaxupUx6NbUaEWi/y1Uy1q26SBQQf/tSjOD1IJGvsz
         l/pr3UYOepZQugq4IDXYNoHxly1ZnTRA2eYRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119235; x=1793724035;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vGOrY3CisGPc8VMRVO//aXg6OQh93vx7xg6bEqOVs4=;
        b=LdaJIqp5r7x47kfE/mDeQtasXXkKmuuRJ9149L76XfDzqxBeyR4MYqV6/xmRAoPFsS
         9GPJamlMmTDzGgmr1xxg+GExIQdbQRiJR35sJlbU6LNin6Zim+N/8BConMOKNtI38GcP
         HntXhaaehjFHVqpu+kH1fowdCkqdgbdBy91udMFX/vYNFTmX7a4Xuj+mJsz+SLWbjaMu
         ubLr4lSCuAxHy9jazkDDCt+PuZ6xqImzCPUbiC6k0ozVQFILIOb8M7EfvG5GoFs4KCNG
         F0A3IQPIBqMPAoJIbQp93VptqaZiBcP5OLVJ9t6LfK6QrP+vlcW+EEZMANJi9jjzDDJt
         qvQw==
X-Forwarded-Encrypted: i=1; AKwUvByqdiSslTjonBjg+pDaW33gJHyN3cTngPdlOg0Oud0wgB6SOCvDyUyOhCVmXqpJ3icNzolVYqpvLXGsUeu5wSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQdRG8Pqa436WgvMnzwqLFmOJrdAfuiCJA0NdqSwYScR201gy1
	0aMyCIhgKTVfAnR6LPVSexeVN5Vi2kyWkgDGqixRcgtbBnPbAFj1nmz3lRThL6mOyOk=
X-Gm-Gg: AYBFou3gi098MlJk3kG2tcQx9lnGa7OwX7a3EXUUXvsxaHcisPDpUtm5o4Bw7HkMIu4
	B4nM2VJEHuXtCilOJBVeyGY+/2AzdYHCVlmz+m0Wabx+pJd01lBODkbEDlrht+SH0htc6sFAKy5
	2+9kP4wBcz4BSDfk6FRioHl9KAsow0m9AeWMAbb1qloQn7buCX1ZrawZABwl8oGX/jcMueRx432
	hsCYPD+gvrJlA8FpxYU1i3oMAszV3Qh2rMOkj5vdVtRHvr6xQVt+ZuOJ5G5aKOskgEAzf3MnGSz
	h+Db1VT8JKdOMVs1ymUODsIT9ix5XJh9bsxyZfYE4IPwA45ynAqxew1a+9IcLS7PigUNvXmGP7Q
	elj41+DomzIWNpektUgUTAm9Cr19YjXlPI0MwN3Vcb2eh8DicXkTLs6YqVqFRMJjqU2NP8iZgDV
	VAoPVNDUtNicE85hVtY8dR5B5oaeIWHW8enmT9T9Zz1DWGvc9bBrXt32DYmTH8OlkHhOjGmvuhV
	HS+gltGx8mH5F1eUmTdKD8LQKluyc7sEJVTZk6tUamWcAQusm5nxAmzM/j+8cyC5+2ep9hLK5TW
	gHgLWVMxJpNAm0vJm599ohrObmPvKcQeYmIB74mgDZbvKHhI90xDNYdxeU+YwO6F+xPCFKQt9+o
	vE2SY+esEJ099E2cDG+brGwYLK81tfnUHan+KGgO3KE7HJww1sT9ypmOQLGdv8h4Tm2LHvaKl2g
	==
X-Received: by 2002:a17:90b:528a:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3adead57da9mr8291010a91.15.1793119235223;
        Tue, 27 Oct 2026 09:40:35 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066d631sm4569992a91.17.2026.10.27.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:40:34 -0700 (PDT)
Date: Wed, 28 Oct 2026 00:40:32 +0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
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
Subject: Re: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap and
 remap
Message-ID: <auDUAN9xAQRQhnCo@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
 <auC7_5XYr31fimvL@gremlin>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auC7_5XYr31fimvL@gremlin>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Lorenzo Stoakes (ARM) writes:
>Sorry, in mm we require commit messages. Even for tests :)

Sure thing, I'll add one.

>On Tue, Oct 27, 2026 at 07:43:25PM +0800, Chris Down wrote:
>> Signed-off-by: Chris Down <chris@chrisdown.name>
>> ---
>>  .../mseal_system_mappings/sysmap_is_sealed.c  | 92 +++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>> index ea75ad537620..83b4fadfbfe7 100644
>> --- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>
>Why on earth does 'mseal_system_mappings' have its own directory...??
>
>Ugh I don't know how I let this stuff go on the original series :/
>
>Please, for the love of all that's sacred, move these tests over to
>tools/selftests/mm/. This is an mm feature, for our sins...
>
>You can do the move as a prerequisite patch in the series.

Will do, I'll make the move the first patch.

>(And, again, I really do insist on your change doing some cleanup here as
> well rather than extending this stuff.)

Yep, see my reply to 1/3.

>> @@ -10,6 +10,7 @@
>>  #include <unistd.h>
>>  #include <string.h>
>>  #include <stdbool.h>
>> +#include <sys/mman.h>
>>  #include <sys/utsname.h>
>>  #include <zlib.h>
>>
>> @@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
>>  	EXPECT_EQ(expected, sealed);
>>  };
>>
>> +static bool find_vdso(unsigned long *start, unsigned long *end)
>> +{
>> +	char line[MAX_LINE_LEN];
>> +	bool found = false;
>> +	FILE *maps;
>> +
>> +	maps = fopen("/proc/self/maps", "r");
>> +	if (!maps)
>> +		return false;
>> +
>> +	while (fgets(line, sizeof(line), maps)) {
>> +		if (strstr(line, "[vdso]") &&
>> +		    sscanf(line, "%lx-%lx", start, end) == 2) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	fclose(maps);
>> +	return found;
>> +}
>
>There's shared code for this kind of thing, please don't duplicate a
>/proc/self/maps thing if unnecessary. Also there's a nicer ioctl interface for
>all this.
>
>See vm_utils.[ch].

Oh thank you! I will use that.

>I mean arguably this is an mremap test that belongs with mremap? I guess
>debatable...

Hmm, I'd lean towards keeping it with the sysmap test, since it's really 
testing that the seal is enforced on these mappings rather than anything about 
mremap() itself, but I don't feel strongly if you insist, just let me know.

>This all just seems like work that should have been done in the past when this
>feature was proposed, and doesn't depend on your changes at all AFAICT? Maybe I
>missed it though.
>
>Valuable in itself, but probably worth sending separately as a result? Otherwise
>it's a little disconnected from the actual change you're making.

Yeah, it doesn't depend on it. I can send it separately on top of the move if 
you like, I just don't like touching things without tests where possible.

Thanks for the review!
