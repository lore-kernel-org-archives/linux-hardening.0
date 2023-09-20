Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF61A5A2
	for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 17:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12D7C433C8;
	Wed, 20 Sep 2023 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695232453;
	bh=tMP6bDZ3KmBgASEl+YHo/RjoiTLwBoEuJVEG/u+4CHA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=EGiOjm+OgZv/mLZ0CDma+LXKkfYls+O5cvNh5ILh5EB8vktG+02RbF6VABpuwZsh5
	 1ouf9qqEkLDwp9TIJC//zcu6i3X0JU0qJvOElJDQTueVNFTU00K1OpQZuAjegxcR7D
	 OSLHO+eL56Nd6WPyetWNCPx5tf/qAciWhcPh9NrwL0EfeatVG9swbzK7Y6WNr/BMR5
	 Y/YTzoGhoukgpYTNqbSgddeMzNsamKN+S9eDxehm/8zlnHhWqFS8t1iqBrNMrrrh0f
	 4L7kkt3o5nMV0gMztevznlkOKFYY468m1f4YQXkhg4nI8+MK3p8TpPMm66V+dy3v8S
	 VJohg5G1E31hQ==
Date: Wed, 20 Sep 2023 10:54:11 -0700
From: Kees Cook <kees@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 linux-hardening@vger.kernel.org
Subject: Re: This list is being migrated to the new infrastructure
User-Agent: K-9 Mail for Android
In-Reply-To: <20230920-zeppelin-heritage-6a15e2@meerkat>
References: <20230920-stoppable-royal-e46a54@meerkat> <20230920-zeppelin-heritage-6a15e2@meerkat>
Message-ID: <D78DBD1F-04B8-4297-8BB2-C3D1F6361020@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 20, 2023 10:17:50 AM PDT, Konstantin Ryabitsev <konstantin@lin=
uxfoundation=2Eorg> wrote:
>On Wed, Sep 20, 2023 at 12:57:53PM -0400, Konstantin Ryabitsev wrote:
>> Hello, all:
>>=20
>> This list is being migrated to the new vger infrastructure=2E This shou=
ld be a
>> fully transparent process and you don't need to change anything about h=
ow you
>> participate with the list or how you receive mail=2E
>>=20
>> There will be a brief 20-minute delay with archives on lore=2Ekernel=2E=
org=2E I will
>> follow up once the archive migration has been completed=2E
>
>This work is now completed=2E I will monitor the performance to make
>sure that the new infrastructure is still successfully coping with the
>email traffic=2E
>
>If you notice any problems, please report them to helpdesk at kernel=2Eor=
g=2E

Thanks Konstantin; I appreciate the work!

-Kees


--=20
Kees Cook
