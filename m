Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6D6AAB
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E17DA4;
	Tue, 10 Oct 2023 23:42:54 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B6gOcJ53664973, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B6gOcJ53664973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 14:42:24 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 11 Oct 2023 14:42:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 11 Oct 2023 14:42:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 14:42:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kees Cook <keescook@chromium.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com"
	<ndesaulniers@google.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Subject: RE: [PATCH] wifi: rtw89: coex: Annotate struct rtw89_btc_btf_set_slot_table with __counted_by
Thread-Topic: [PATCH] wifi: rtw89: coex: Annotate struct
 rtw89_btc_btf_set_slot_table with __counted_by
Thread-Index: AQHZ+JIdINNFwhWCA0q/Xu1rquYi7LA9Aa0AgAQqFYCAAv5lMA==
Date: Wed, 11 Oct 2023 06:42:23 +0000
Message-ID: <a47f01def02c4ccdb0d4ca3967ad7584@realtek.com>
References: <20231006201715.work.239-kees@kernel.org>
 <4716f3c7bf3d34ea25229edd5250f5f0cff639d8.camel@realtek.com>
 <202310090953.B7CE5CF4B@keescook>
In-Reply-To: <202310090953.B7CE5CF4B@keescook>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kees,

> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Tuesday, October 10, 2023 12:56 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: kvalo@kernel.org; llvm@lists.linux.dev; linux-kernel@vger.kernel.org;=
 linux-wireless@vger.kernel.org;
> linux-hardening@vger.kernel.org; trix@redhat.com; nathan@kernel.org; ndes=
aulniers@google.com;
> gustavoars@kernel.org
> Subject: Re: [PATCH] wifi: rtw89: coex: Annotate struct rtw89_btc_btf_set=
_slot_table with __counted_by
>=20
> On Sat, Oct 07, 2023 at 01:20:43AM +0000, Ping-Ke Shih wrote:
> > On Fri, 2023-10-06 at 13:17 -0700, Kees Cook wrote:
> >
> > So, NACK this patch. I will prepare one or two patches for them next we=
ek.
>=20
> Ah-ha; thank you!

I have sent two patches [1]. Please help to review and Cc people if needed.=
=20

[1] https://lore.kernel.org/linux-wireless/20231011063725.25276-1-pkshih@re=
altek.com/T/#t



