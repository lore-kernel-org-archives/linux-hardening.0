Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85901B29D
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTDFbkkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D29C433C7;
	Wed,  4 Oct 2023 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696448484;
	bh=7+Gq3TEuThPt19tFGYS/xaTeAGhxvLnYEJUTShtLK6M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fTDFbkkjBcGxnPxkk/gc/J8Fvjel/aUAv2fornemp4v8ns5zCASBoX1qX0Ih9Q9Fk
	 JtusTkT3vvlw+llJlWgxkscxn59QDsWMwxBpIeFqnBBOSVBwAUF9WIG0VQww0P4fUC
	 OQp3SsuCZop7oUONQcC2cEH3X7CJm5b+n5GtxObTi2zJSgbt/D2rYdbJZewJHdl+T4
	 U5+YluyAslBBKZUB5Xskjg6feOXO1h4nwnGw5cVj/bOUMf1TnqkVnHvi3P5y4WebMQ
	 6WjpiglKYio3MCahncFy+zrG52BAWo7N9KrqYO/7Gq9M2KjbGi0Hic/BEXTuQFkrDa
	 YbZjV5yuiIm6A==
Date: Wed, 04 Oct 2023 12:41:14 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>
CC: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
User-Agent: K-9 Mail for Android
In-Reply-To: <f258a7e6-0728-4f55-a71a-6e99113ce7e5@sirena.org.uk>
References: <20231004193441.work.109-kees@kernel.org> <f258a7e6-0728-4f55-a71a-6e99113ce7e5@sirena.org.uk>
Message-ID: <65EBA3C4-46B6-49DE-8F03-AF0E2776FDF7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 4, 2023 12:40:00 PM PDT, Mark Brown <broonie@kernel=2Eorg> wrote=
:
>On Wed, Oct 04, 2023 at 12:34:45PM -0700, Kees Cook wrote:
>
>> +++ b/MAINTAINERS
>> @@ -20116,6 +20116,8 @@ F:	Documentation/devicetree/bindings/sound/
>>  F:	Documentation/sound/soc/
>>  F:	include/dt-bindings/sound/
>>  F:	include/sound/soc*
>> +F:	include/sound/sof/
>> +F:	include/uapi/sound/asoc=2Eh
>>  F:	sound/soc/
>
>The SOF header is also missing from the entry for SOF=2E

Ah, right! Can you take this and tweak it with the missing entries, or sho=
uld I send a v2?

-Kees


--=20
Kees Cook
