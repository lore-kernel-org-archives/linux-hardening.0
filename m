Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3B33F597
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149398; cv=none; b=J+0MSc7uW5INtrKg2wIYufZls27Dy++yyDX+r9zYpuIdqw6m0X8LZGOrcwWp8vZt8Q/9ZIBHFgKq8fyil5jMDZN0IV0i5zeSEdczH7IMR/3P3qMJUHkY0nS8V1Bt3ZG8rfXL1Gchx2H4mWUiLQ+N7zi6pPabhISY9DgdU56IEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149398; c=relaxed/simple;
	bh=jN+ntvQx7XMe90WqQwIvL0aJaFoOBXm8HDhv+fV21bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b95aZMKF6/D5AKXTdrUKYia2wlouBMoQzdj55OOPgiBwuTq/LegvEfBtjlKPwV0y+Ff0Ad2myEl50aKqtm/bl/A4dBAFbiZfNYTaS2NXN4SGBUvC+BK41AT907zfE+XoCfELXH/mDxNMKKShR9DvQYLTqHCawONnwWCXCQwc7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hK5Lhhej; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hK5Lhhej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782149395; bh=MRZTD3Q7gWgv0zP7dueG5+s0ijy1Dv/xYkxjl1UlGo8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hK5Lhhejr5OK51nQCVS2gaQ7lRcZKXzgZ2p73LB3YstezS6lvGMRZ/4lrdMwkXDBbvamszAxHugc7iEL7eGw2XUo7B0tvaeW1lE7S2BifQuPPvWW/5r8c7cPVt21QqYghet7EIFhptVZYdqV1oIdhQ24Jq2rx/aSkcaWN2ynJGSyesKWB7seDbXvl+48ZX7+WJRgASUbWtsaAH+sVQ4SwXJojUDEuVCAxsZTXAtKOgErhSD7gpQ4YK9q40Y/CGhXZr12uM8jhwB834DnrPjKw1UTO5d0fcnrYlVkkGdCBBugHRcOc7RxuZ759HqEmCNLjj0MWjLRhIr3yDMrBUDtcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782149395; bh=KQWLOj5JR/zOPs7ETEuGpvQESBY0QdRWN1zzyxv/KaL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ccSim2t3Oxh+Z2nzCpR/CU5/c3h7TQSlOP9PNJReFTil88aa04+YZ0e9kwusyAnqdrUvu1DEfOyscpcNaaRxO4eC9Tm7S+pEFP6o2VbTUGWz1S1pnxrPp5gUI/YmUoTocoMT9wrKz85TQ3NGOUPMB5tPu3KDzho73H3cruOm5kEd7iZABb/Ir5lTRgHuM0ZgfcrAPMQ9l377BEb3C7llvm4bZ7SBxHQm71DBe6s+n89AZA/7NtjUo460hMFk12snyg7zGLafCAS1pY9DdWdIjJWAWR+VRauHPk9tctQrtdU6TQvhqXIm0hfLFAZ17CGp2R1zyCOeNji4CVCrIUUw2A==
X-YMail-OSG: _v0QZ_cVM1mqB_Gn.QIxeLIkurU.mRXKN.6I2llJZlsSvP5MqzZRSl2ufGD_rWy
 Yqwy3oZT8cr0AXXzrineJD2aVb51Elqc1vtRj0xElkw.vgRtXuwkcaOW_lzPBjPP32FFVBDfobjJ
 61Yhjy03mU8FZ7iPawU2DMZskZeyVY5k4CHH5A466rSk__ZZfknq4zjGQFkz43.0FwXa2rIzr6S9
 v6dmFGSOLSCjR5_9jX0YX9OErEQ1GHzqv92KAM_bmjc5AGyTWpphmVwb2Q7f6gAUQlWpEhkuV9en
 zRGU_taIpbvx34BHuXXlw57JJlrGsQYnL2re1LnZyepnZ3lrfh0H0Ow6hh3BYc277jABLmm4_4AW
 3ZzDd8i0XH6gPWTPyr4jxGGD_z9JEsrM_qCB2oVJv3hXR2uv4OtMG8MhTXPYKT1laPLf5ZuQYVkg
 HBZkMBzvfkBxYtZ_aRgOwxdvBAdZb.f4pqBWhgQSeQn8YwZPFwwOWV5_okr37TwnV1UPJBaZPiHN
 mIZNCdyu3ShWNIxmOQE6a_p4eyzBl4K6WYJOZanCi0cbtZFIJfd2H4WukqqTEKj3PtkzLAianM5f
 v6ItNaPAuYPlYc4QGs6aBhnuIBDOOGLOWxXZ.ItK_ESNbRCspCrAr63b7Y_vLazNsappsy8UA3Ox
 vKuJqUce0bGnSQxr62OlAzPC7sAj0jOVEZG19Im1F9.PTep9ZBpNLjAeZ9cyeX.Y3it0V0EzW9p8
 MW_vHF1jtBAu8uT8QmFpcqpYEj1bky2COw7vyVDmkAEMk7hRgQSmR_zPARemBaFju1ltHMvQbaDg
 TuvM1hZiXrtyQMQJcAfpyf348gMQgUc3af6wMzRKfYqELQ7jeb7nsQWw73QMFKlV4OdRNHf1XTZD
 XOI._vmm4YG6klwqQQ5TaDp6lbES_J5.9IwYZ8_xluLDD6xQHw93WRPfajI3T7YUkl6.G4BEyNss
 Z_wgKxPq5t2rmm1BMeKuv5XqjecoVhzK9Eo2hL.Mirx4o0bbXseuWnZQbVNADrAT5LT0eO1VXFwh
 6SPq1PZ7siQKCUt8S97hKrvnV7anwa0xeUGyV0ylNYjj3w1xTJ.KNpt2GtBiv_Tn8ljdwnWfDrNL
 vTl8EEnNQVgEWOpyklWgy27af9uayNBCL1LgueUwe3mRgc9KZJaz2GLxpUOYwOJQjIqIBwDLYspf
 FDg8d0FKUavVIlA5PQDPYoRyX0vQUmZm9qLr2wNyDT_LftKKn.rDNVTAnW.XuvEct7VH_NM3JnhK
 b7Lrb_DC7f6OlzOaIBMnRcIBt8RosTbe_MFHvmQda26DB_NwtCcFIR3z2040u2TvrUobCddaJx3b
 iAtIdlbM0cEImPmeQ_bzt7dAk..9ibt8LuY5yuf1HWw4wgUACTawQen0lRxUNz98.NHGOt2Fkupk
 Skes8vlHJwLnCL41p3BkPg6OOF7PrJ3iNWs7qnN6nvq0U1qxKDGY7KhLequ6Ffva7kEmPUcYUAHO
 0dS8WieQVpmwHWxG8nT_lmzuENRXRCBygwOZRdllJdLNrV8B6CXJP1YAfS0BUTNxeEWRfKAt2lT9
 fWhxzdq0BDwgJ5AAY8GoyJmfWG3oKMx57VMPMsZ0p0O24QhRJGLH5iWSLi_oMxLCznn7.A6RgLDl
 VBSBwn2xoq6iSt5duBhsquWb.SkA356Ze6TqNBdxg1A.f9Fg7kIKHqj.q6WQ4fHigXfmf6Bfjt32
 gYWQ74cjsVqms8ja_Tt3SZEuYDZTo7wxZS.sxg30Dq6r_G_PHt1ryXp5jZ0NL3eCGmN0UyUfh_cB
 qsVh9.jb.406ZWOEtstFj4X4xnS7ilSwg4FR460ff0JsURIsVorB9cKxAEPB5iQEIEHnXtiTpKHB
 AMTDnJ29LfBRHz6yArDezrcoh81ovFTmyJugyPqlX88WHDew009hU8mLLlUwKVBbv9__MPi_.Rw8
 IscgIsTd5nNFF_gxiCkbnOhBS6N6RfEcW_pUatH370i4yMZQdBOrMxKkF97gsQdgQRh2LDATB2oh
 Sue5S5D1MHkFVrnwMkNQDa4zkuo0xNlsGBLhm45wmkwCOBqNa3_rtJ4koBbfTWUYRZluW_z2MA2w
 5rFExcFrPBEPtuP.u6d3IHY.j2RF24dlmioqQwUMDjGeFKpjkKN9Mu7Q2FxuX48qWZLrSkdYruPG
 K18ioYZ8c4pccNQpwkTf5kcEL6Vn8rDRRSYMeQFKbiONH4RaYETrLZg.u1OC728xa_AdTJp9b7uS
 RBV3oKPuyLlg7JNSzlroM.7wuc_h9EYSb927xV356C_OtsJDFQqN6pWQA6f4_AmhsmLe.EzsRY_T
 1i4.dU4xlFw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: acd1fe8e-7735-42a0-9678-7d5210fdc494
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Jun 2026 17:29:55 +0000
Received: by hermes--production-gq1-7bb7df5c46-m46kc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6511586033ac51e44f024e3c0f8c7ae;
          Mon, 22 Jun 2026 17:09:16 +0000 (UTC)
Message-ID: <873aadcf-c0ab-4238-8e50-b507dfd718c7@schaufler-ca.com>
Date: Mon, 22 Jun 2026 10:09:13 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
To: David Laight <david.laight.linux@gmail.com>,
 Ian Bridges <icb@fastmail.org>
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ajlN94VO7BYNUTAy@dev> <20260622175301.6a36756b@pumpkin>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260622175301.6a36756b@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26016 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/22/2026 9:53 AM, David Laight wrote:
> On Mon, 22 Jun 2026 10:00:07 -0500
> Ian Bridges <icb@fastmail.org> wrote:
>
>> In preparation for removing the deprecated strlcat() API[1], replace the
>> strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
>> seq_buf, which tracks the write position and remaining space internally.
>>
>> The seven open-coded WARN_ON(rc >= buf_len) truncation checks become a
>> single seq_buf_has_overflowed() check after the string is built. The
>> kzalloc() and its exact-size computation are unchanged, so the
>> measurement string passed to IMA is unchanged.
>>
>> Link: https://github.com/KSPP/linux/issues/370 [1]
>> Signed-off-by: Ian Bridges <icb@fastmail.org>
>> ---
>>  security/selinux/ima.c | 35 ++++++++++++++---------------------
>>  1 file changed, 14 insertions(+), 21 deletions(-)
>>
>> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
>> index aa34da9b0aeb..3d81093d16aa 100644
>> --- a/security/selinux/ima.c
>> +++ b/security/selinux/ima.c
>> @@ -9,6 +9,7 @@
>>   */
>>  #include <linux/vmalloc.h>
>>  #include <linux/ima.h>
>> +#include <linux/seq_buf.h>
>>  #include "security.h"
>>  #include "ima.h"
>>  
>> @@ -21,8 +22,9 @@
>>  static char *selinux_ima_collect_state(void)
>>  {
>>  	const char *on = "=1;", *off = "=0;";
>> +	struct seq_buf s;
>>  	char *buf;
>> -	int buf_len, len, i, rc;
>> +	int buf_len, len, i;
>>  
>>  	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
>>  
>> @@ -34,33 +36,24 @@ static char *selinux_ima_collect_state(void)
>>  	if (!buf)
>>  		return NULL;
>>  
>> -	rc = strscpy(buf, "initialized", buf_len);
>> -	WARN_ON(rc < 0);
>> +	seq_buf_init(&s, buf, buf_len);
> That is silly, you need the length of the buffer not the length of a string
> that is the expected length of the output.
>
>>  
>> -	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
>> -	WARN_ON(rc >= buf_len);
>> +	seq_buf_puts(&s, "initialized");
>> +	seq_buf_puts(&s, selinux_initialized() ? on : off);
>>  
>> -	rc = strlcat(buf, "enforcing", buf_len);
>> -	WARN_ON(rc >= buf_len);
>> +	seq_buf_puts(&s, "enforcing");
>> +	seq_buf_puts(&s, enforcing_enabled() ? on : off);
>>  
>> -	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
>> -	WARN_ON(rc >= buf_len);
>> -
>> -	rc = strlcat(buf, "checkreqprot", buf_len);
>> -	WARN_ON(rc >= buf_len);
>> -
>> -	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
>> -	WARN_ON(rc >= buf_len);
>> +	seq_buf_puts(&s, "checkreqprot");
>> +	seq_buf_puts(&s, checkreqprot_get() ? on : off);
> That lot would be easier to read as a seq_printf() - with %d and
> kill 'on' and 'off'.
> Why does 'security' code so often look like c**p.

Sturgeon's Law.

Also, it's pretty rare that developers outside the security community
look at the security code. It usually only happens when there's a global
change, like this one. And to be clear, reviews like this *are* appreciated.

