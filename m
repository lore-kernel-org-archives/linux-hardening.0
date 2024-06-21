Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A016E887;
	Fri, 21 Jun 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962752; cv=none; b=YVS1HBxo+a3tlpg2cUqdzbFOQ5MmCEfqmbZdCPL+79KALe2v0bequsAmS7gA5/sUP0zI5XDaMMT7WrdypV4YuFRh8dHLgiyXVwygQsB+Hx798fzudDwOWgIYPR4KaeJoydVUZodMBf7oIFOwVcPHtv0dmEaSS50M4cWsrAwXDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962752; c=relaxed/simple;
	bh=T/aPMOBDsmq50nQycGqwzMw9pkeImqzsw4kg2uOJlsw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ns1bo9DayO142QHhho1Yb3a3KeqppUJzyQkyo7ZjC1LJYsXtbjrKoEY/Cg/Q3FlECEDoYuLGCf32vsKmhkVxWSGmNyTIFUH/BNdV0vw3NerKmdcqH8xBK9DOtX8hpmB0ZXfznI2qyuJTaYlGxfUQsPi//k5JTWm8vTsvG6zycN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IJLF2ri/; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IJLF2ri/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718962681; x=1719567481; i=markus.elfring@web.de;
	bh=LI+TUiiSLkqLlCWlQdpsZtnsM9Nk+W/XQI+XUAJ4VZ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IJLF2ri/yYIifJt4pww1wpP+lWTM2aP+oEhxmMIMpFQhV44AKRES8PQFvYekv9Ct
	 0hJm19ZpN2vyQrkJpnoBEpJEOQUfb4/muTZE+u/lB2UP/5e2FmQmfNlPqKg1XMZUd
	 cp5VHrQfhBmCDzq5nAw1360V0qKIEoVTAiJLzxAmWSg1tgZfUBk/JAfGqN29rRhvt
	 EhnMp3Fq7DtAeJL/KkKXguCS13qnLqh/6gCNjuPYJig9IRZzL2KttHJTocas0JNu2
	 3ItBqu3E4lVy32vLdqZv81P30BTUHfY2kmR9hJvee4+ldvojYOCgBBkqlpCpNsHKo
	 Q3krXbwfmClHqjXM8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1sNKnz09zW-0099B3; Fri, 21
 Jun 2024 11:38:01 +0200
Message-ID: <4c840379-5b7f-40ea-b42c-08031cffaae4@web.de>
Date: Fri, 21 Jun 2024 11:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Hyeonggon Yoo
 <42.hyeyoo@gmail.com>, Jann Horn <jannh@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Julia Lawall <julia.lawall@inria.fr>,
 jvoisin <julien.voisin@dustri.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Lee Jones <lee@kernel.org>,
 Matteo Rizzo <matteorizzo@google.com>, Pekka Enberg <penberg@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Ruiqi Gong <gongruiqi@huaweicloud.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Graf <tgraf@suug.ch>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20240619193357.1333772-2-kees@kernel.org>
Subject: Re: [PATCH v5 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240619193357.1333772-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BEYWf/UP7l4wwAmSOrMH8bbsktOyISHBhJIR6aSVd/kq2OOxTQw
 ftrg7iIh10zf9RcGZdVCIlSYg8D0ycukhR8p0oLjYV2Up0bzkbmHVDUVjmMq3//AyUeCODU
 OdoEwtlERy9p8a5U+l/9v4RJLFk/5oH8U51MrVi+AbWG1Y3NAQyc1jbPKFNQjvB7KLBbHyM
 xkaAP/zWFXEqp3YG5gm/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gfasfj2649I=;miT2W0lf6qO791rq2eAxJ/XCoDl
 Z2UnNOfndQw/ouoCDL4ep6yQmr3s7xRRtOmnv8UvLzIDGC3PAHzbkHwyHsgHBBVigBYuxmdFu
 ZDtWSvotNeh7tmpH1sKTEOQlFcswJ2K+oU4d54jD18TlQIdIQi3t8ODeV1TNpcEAZURyF9t0x
 VTr7KeSDDX16OY8Kn9Jf5tKIN53vBI2i7OLVTbqKb5ImxGzuFlpFEvLfCSMe3HwZV4ROcqmp8
 oVtjlBAwhJ1Fxt4lfRI0k9agml3kVGS6neUMKuD5wC6CROCY6RXgY/juF25KwpTuWFS4JRXdv
 0CUDmqVSWDnGtFU9YnkIWKTrtXu9b5cc7rHi3iDV3bEwB2/n859kuOqUarlwVgPvCB4/grHaP
 9om0m0jvQHYasZ3Bzk1lgmqmdq/Agw5htgMMlcFWIA+fl+GGv3U7peUIpiEinXjPSlwA7iIKu
 /PeCw5hy8Iu6dCmxvQz7Tvez8KSsNXjYVx6V9y7S15NaVSKkBKQjGsFfoCM3ujTKmupduer98
 5g4w0m89rxKM8BR84PAbbs4zTUHq+7EvpZkoBJ0Pcb/gnKWCWjqBBnLCdIKlcSIXsEq/y9/s9
 UBvVc7Ug3xNz09lywFjJSQVeCMmL9GgVm17JreGF0GwYhYQ3kzDyYjDfQSOKoR4cX+D8o13eT
 1XealuCgWVZ+3YFQ07oTbhy6kWYKvqpkRmds5zBgGyl1OEB+kXk3wA1izfMoC1/s4bREEXLfb
 TK69yDbQqRwM+9JwE9ZNJlZ7uv77CrWS+azX0TkfMP+bDQqbKtMyyp+Y8ghv3w6v5vd6hY7RF
 YCQVV9uR7Vi3sdw0VfM7ASQT0bl/a806XE9HG9SjMtWag=

=E2=80=A6
> functions can then been built without the argument, =E2=80=A6

                     be?


=E2=80=A6
> +++ b/include/linux/slab.h
=E2=80=A6
> -void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int no=
de,
=E2=80=A6
> +void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), g=
fp_t flags, int node,
=E2=80=A6

Would you ever like to reconsider the usage of double underscores in such =
identifiers
any more?
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus
