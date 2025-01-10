Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB020A5FB;
	Fri, 10 Jan 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536504; cv=none; b=qEK8BfoxjHYjj+oEqck2VaPqdq22/KHKZuJ1aUut7l3UJ3i+1E0uGRtQNnGIeXr/Z5owcTCMlHN2DmpeMUgrtCsZ3/LIE7G1sL2K3ZqwOBltwYKa1/kaOeaP4UaZ+B0iACfzY19IBTP37absx3uMJYE6X0rq2WKRMEGm4Ioz5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536504; c=relaxed/simple;
	bh=zClZJBAhEw254+L+vqgXeZhB4ull2qPmPWhvpuQkIwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpQiV+pofQ7mQStsCC9eIcLonJ2EbHx/XzZ75dRpWJs3YSAkrf+vgvzzDpdqk5ESGs9a8Lw4cem1ML4RLXf0q7I4VAmaSc1HuNfecSeRwmkAaNptb5HS0BXq5OLCmsVVh/cW6h+ShKZZ7oz2DLvot9jD/CgZjqdipVRIExwfUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heVq/Csj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heVq/Csj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso3681634a12.0;
        Fri, 10 Jan 2025 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736536501; x=1737141301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zClZJBAhEw254+L+vqgXeZhB4ull2qPmPWhvpuQkIwI=;
        b=heVq/CsjI0XYI4SrVSMNZ9OCYCiiWbdIS5eAIWOhnxWCCb0N7IjX+4ATOck2Dty6gU
         h+Xps2L3PN0u/C9ry8xSwg1JP/kwY/MhJb4YKGp+9azl+VIqTT/H1Of3J1105zpbx4PY
         feEc7jN6XpnbOeOGMIyXHT75jYLb2zqhUxgLyGteA/sLdxt+hEjr5f+jRDHCXdp7c9Sh
         Of+lNEHMykeRmKPrhj+rI7+eEj6EAwDI7oBPL368U/1gf/ZLiWdeBl1deIjOGycZpnmL
         zWihrqdlmsBI7xL5+8780H50BFvBtj/cWmYpdlrb10M8hBf3L6yVNr5YF9CODpRXqIVj
         aNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536501; x=1737141301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zClZJBAhEw254+L+vqgXeZhB4ull2qPmPWhvpuQkIwI=;
        b=aqp2G5JnUOrPN2EFt0nA2KRW17yfchXMv5K53AmD9mRQB1Ivc2Y+lYKjXlE3bxDCfZ
         Jig7geh3Hu3D6yqvHMLab5W0IKKQy4qgbP3jFeUXhbiPun/r9GUm1GFa0P4UnR2gkuIi
         VjC7etlDKvp2E6BFBLpVgEidh3TBQbTTKnXscWYPITBZnWvToY8iTdcCbwbBCsW1OCFM
         ShBE8jwO1O57zgzP5bTh2d1585l043gZFRrFu9wPQx+UfsnONP17WEzQUoXEPsLykd9N
         KVr80NyR1B8/VomkidnpAdeODq7dB8EBaZS4jOxlnCFPjc1xQuDh0RWnuRPLtt9S2zw+
         G7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT7kaTHxN5Eee1P0flkTkAbL1HZhXJQ9qfS18Lb+d25CyIKzGd68VWAxLoCh4fVwWC/IKOXCzuQBm+2Ay5noU=@vger.kernel.org, AJvYcCVvZKzdu/G1HrnWH0wQI/7xdvThnxIPibNlGq9xdaJEW8ipkX/03rIt/AtG3cPbZnJjw7mry1r2s803yYZB@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8OWAe08MksN1lntlqfYKOv4CkOh35baHNx4v68oN9oiWgGyv
	CWMwTbbsQQ6qezEK2QKTwyfLOZ0yG2YIr9KnVSu1kQMUJVJUQYo3VLoIbScXc9OaHnNLgVDe9is
	/EKzXhFi5pD0Bq0Hibde722N9FP0=
X-Gm-Gg: ASbGncu8avv596Jmike3bSSjAQBmd7RFin3RICmZ7lZS5XIWqPiZYpGybqClqDzM3CH
	EX09r31pTn3rMOX1FuGsS7IVaEGDIyobDX22A
X-Google-Smtp-Source: AGHT+IGZzz6OkaZA/AYyGYsZofAg53/Iz1c31dr3qcwEcyyLsvRxJWn7U2djDvV8m2KuLGI6XdEvYwWd7yiTxH+89ik=
X-Received: by 2002:a05:6402:4025:b0:5d4:3761:d196 with SMTP id
 4fb4d7f45d1cf-5d972e06cc7mr11009109a12.10.1736536501147; Fri, 10 Jan 2025
 11:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501091405.a1fcb1ed-lkp@intel.com> <202501090850.F23EBEBC5B@keescook>
 <202501091236.E3EDA2188@keescook> <pep7tppcmd77ejaa47bhajc3uoy2q2n3cladgc4btdri4mth65@dqjulq2hx4l2>
 <202501091256.4F3B2E8@keescook> <CAGudoHHymwdk9ChLK=JcPtRD8BSTRDG9B78yOzcRoBGWFzumng@mail.gmail.com>
 <202501100853.CC2A15B6D@keescook>
In-Reply-To: <202501100853.CC2A15B6D@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 10 Jan 2025 20:14:45 +0100
X-Gm-Features: AbW1kvZ4pMJnY-qY0554TyvGljDcZVdXrEPN86cTu0FEJksQIusKVQpn3Io98LY
Message-ID: <CAGudoHGR9nbSDTUXt02vi5VmNn4eOFbgNiTfvTThA7Kecz4SWQ@mail.gmail.com>
Subject: Re: [linus:master] [fortify] 239d87327d: vm-scalability.throughput
 17.3% improvement
To: Kees Cook <kees@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Nilay Shroff <nilay@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 5:58=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Jan 09, 2025 at 11:01:47PM +0100, Mateusz Guzik wrote:
> > That is to say, contrary to the report above, I believe the change is
> > in fact a regression which just so happened to make things faster for
> > a specific case. The unintended speed up can be achieved without
> > regressing anything else by taming the craziness.
>
> How do we best make sense of the perf report? Even in the iter case
> above, it looks like a perf improvement?
>

The kernel without your change compiled with gcc is leaving
performance on the table in select cases, namely when it elects to use
rep movsq for sizes below a magic threshold (depends on uarch).

Your change has the unintended side effect of changing
copy_page_from_iter_atomic to use plain memcpy, which justhappens to
be the right thing to do for this particular consumer.

However, it also has a side effect forcing of a memcpy call in places
which were optimized just fine -- for example if there is a spot where
there is a variable number of bytes to copy, but the range is small
and the upper limit is also small, gcc will elect to emit few movs and
be done with it, which is faster than calling memcpy. That is to say
for spots like that this is a regression.

In terms of optimizing all of this, the thing to do is to convince gcc
to not emit rep movsq for known problematic cases. But also not mess
with places which are optimized fine.

--=20
Mateusz Guzik <mjguzik gmail.com>
